
# Steps to create a release of the project.

Before doing the deploy a release must be created in master branch.

 - Make sure that the branches are up to date.
 - Merge master with dev.  
  `git checkout master`  
  `git merge dev --no-ff`  
 - Find last tag in the master branch, you can do it using this command.  
  `git describe --tags`  
 - Add new tag making sure is the next tag. For this, you should increase the patch (z), minor (\y) or major (x) version number.  
  `git tag vX.Y.Z`  
 - Push master branch and see in control version repo if the merge commit is right.  
 - Push only the desire tag.  
  `git push remote_repo tagname`  

# Documentation
 - [Semantic Versioning](https://semver.org/)
