# LinuxContainers

Dockerfile + bash script to create a portable and light weight linux dev container.

Make sure you have installed docker and just run the script.
This creates three images.

First image is ran by running "pc" in terminal, creates a linux container which can be used to test stuff and keep them saved.

Run "lin" for a temporary container which has access to the working directory where it has been ran, after exit everything is deleted

Run "lab" to create a true throwaway linux container, work it, break it, does not matter, after restart it goes back to normal.


By default "pc" and "lin" are configured with the following 

    git 
    build-essential 
    curl 
    wget 
    nano 
    nodejs 
    npm 
    python3 
    python3-pip 
    ca-certificates 
    sudo
