# GIT

# Proxy
git config --global http.proxy http://prx.tapnet.tap.pt:8080
git config --global --unset http.proxy


# Long paths
Git has a limit of 4096 characters for a filename, except on Windows when Git is compiled with msys. It uses an older version of the Windows API and there's a limit of 260 characters for a filename.
So as far as I understand this, it's a limitation of msys and not of Git. You can read the details here: https://github.com/msysgit/git/pull/110
You can circumvent this by using another Git client on Windows or set core.longpaths to true as explained in other answers.

git config --system core.longpaths true


# Edit config
git config --edit


# Git clean
git clean -fdxX
f - force
x - Don’t use the standard ignore rules read, but do still use the ignore rules given with -e options. 
This allows removing all untracked files, including build products. 
This can be used (possibly in conjunction with git reset) to create a pristine working directory to test a clean build.
X - Remove only files ignored by Git
d - Remove untracked directories in addition to untracked files.


# Undo last commit
git reset --soft HEAD~1


# Git empty dir
Add .gitignore file with:
# Ignore everything in this directory
*
# Except this file
!.gitignore


# Create branch with first commit
git checkout -b main $(git rev-list --max-parents=0 HEAD)
git reset --hard
git push --set-upstream origin main


# Git merge overwrite
git checkout better_branch
git merge --strategy=ours master    # keep the content of this branch, but record a merge
git checkout master
git merge better_branch             # fast-forward master up to the merge


# Git checkout tags
git checkout tags/<tag_id> [-b <new_branch>]
git checkout tags/jenkins-PRD-TravelOffice-WAS7-44_2019-05-30_1128 -b prd_fix_20190605


# Certificates
## Git Certificate
### Method for self signed git repository
git config --global http.sslCAInfo <cert-file>
git config --global http."<git-repo>".sslCAInfo <cert-file>

git config --global --unset http.sslCAInfo
git config --global --unset http."<git-repo>".sslCAInfo

<git-repo>
ex: https://customgit.com
<cert-file>
ex: /d/dev/etc/certificates/custom.crt

Note:
To not disable all default/system CAs for all domains but only for this one domain use instead:
- git config --global http."https://repos.sample.com".sslCAInfo /home/javl/git-certs/cert.pem
and if there are any http urls that get redirected additionally also:
- git config --global http."http://redirect-source.example.com".sslCAInfo /home/javl/git-certs/cert.pem


# Import docs to a branch in GIT
https://stackoverflow.com/questions/13969050/how-to-create-a-new-empty-branch-for-a-new-project/13969482#13969482
git checkout --orphan <branchname>
git rm --cached -r .
git clean -fd
-OR-
git checkout --orphan <branchname>
git reset --hard
echo dummy > f.txt
git add -A
git commit -m init
git push ...

# Links
https://github.com/microsoft/Git-Credential-Manager-for-Windows

# PR Patch
<pr-path>.patch
https://github.com/_user_/_repo_/pull/11/files
->
https://github.com/_user_/_repo_/pull/11.patch
