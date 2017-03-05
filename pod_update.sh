git add --all  && git commit -m $1
git tag $2
git push --tags
pod trunk push MBaaSKit.podspec

