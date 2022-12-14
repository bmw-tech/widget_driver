# Run GitHub Actions on Your Machine
We use github actions to check if the code is sound and in the format we expect before it can be merged to master.
It is possible to run the actions locally with [act](https://github.com/nektos/act).
To run the `check-code-quality` action use the following command:
```
act -r -j check-code-quality
```
On your first run you will be asked which image size you want to use. 
Our pipeline actions have requirements that are not automatically met by the micro image, so please use at least the medium image.
The default used image can also be changed in your `~/.actrc` file. 
Furthermore there is the option to specify the image used by setting it as a parameter:
```
act -j check-code-quality -P ubuntu-latest=catthehacker/ubuntu:act-latest 
```