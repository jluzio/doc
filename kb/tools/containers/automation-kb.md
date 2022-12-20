# automation-kb

## GitHub Actions
Intro: https://www.youtube.com/watch?v=cP0I9w2coGU

## Sample workflow
- Push to PR branch
  - image build testing stage (image with test layer)
    - unit test
    - CVE scan (Common Vulnerabilities and Exposures)
    - integration test
    - deployment smoke test (basic deploy to check to validate health checks)
  - lint
  - SAST (Static application security testing)
- PR merged
  - image build prod stage
  - push to registry
  - deploy

Examples:
- Basic: ![Intermediate](https://raw.githubusercontent.com/BretFisher/docker-cicd-automation/main/diagrams/basic-code-pr.png)
- Intermediate: ![Intermediate](https://raw.githubusercontent.com/BretFisher/docker-cicd-automation/main/diagrams/intermediate-code-pr.png)
- Advanced: ![Intermediate](https://raw.githubusercontent.com/BretFisher/docker-cicd-automation/main/diagrams/advanced-code-pr.png)

## Linters
- super-linter: https://github.com/github/super-linter
- megalinter: https://github.com/oxsecurity/megalinter

## GitHub Actions/Tools
- Checkout  
Action: actions/checkout@v3

- BuildKit: allows cache for distributed builds of Docker images  
https://docs.docker.com/build/buildkit/  
Action: docker/setup-buildx-action@v1

- QEMU: A generic and open source machine emulator and virtualizer  
Allows building for different platforms.  
https://www.qemu.org/  
https://github.com/docker/setup-qemu-action  
Action: docker/setup-qemu-action@v1

- Docker Metadata  
https://github.com/docker/metadata-action  
Action: docker/metadata-action@v3

- PR Comments: aggregate comments in PR  
https://github.com/peter-evans/find-comment  
Action: peter-evans/find-comment@v1

- CVE Scanning  
There are several, using Trivy as an example.    
https://github.com/aquasecurity/trivy-action  
https://github.com/aquasecurity/trivy  
Action:  aquasecurity/trivy-action@master

- Kubernetes Cluster  
Creates a lightweight ephemeral cluster.  
Enables deploying to the cluster and thus a simple deployment smoke test.  
https://github.com/AbsaOSS/k3d-action  
Action: AbsaOSS/k3d-action@v2

## Tests
- Unit test: 
  - can be some form of docker run using the test build
    > docker run --rm ${{ github.run_id }} echo "run test commands here"
- Integration test:
  - depends or architecture, but can be a docker compose file using the test build, checking if integration test action for a specific container returns a success code