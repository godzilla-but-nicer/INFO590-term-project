# INFO590-term-project

## Setup

### Getting the repo on carbonate

This repo is set up to run on IU's carbonate computer. We can get the code onto that computer using git. First we have to log in to carbonate:

`ssh your_user_name@carbonate.uits.iu.edu`

Above, `your_user_name` is the same as the part of your email before the `@` sign. Once logged in, git makes it easy to get the code on to carbonate.

`git clone https://github.com/godzilla-but-nicer/INFO590-term-project.git'`

Or, if we already have an older version of the code

`git pull origin main`

### Setting up Anaconda and Snakemake

We will need a conda environment with `Snakemake` to run the scripts. We can set that up on carbonate by first unloading the default python module and loading an Anaconda module instead.

`module unload python/3.6.8`

`anaconda/python3.8/2020.07`

This will allow us to use Anaconda to manage python packages as well as replace the default `python` command with a much more flexible one from Anaconda. From here we can start working inside of an Anaconda environment. First we will activate the `base` environment.

`source activate base`

Now we should see `(base)` in from of the prompt on the command line. This means we are inside a virtual environment--a computer within the computer--that will give us access to all of Anaconda's features. Most importantly, the ability to install packages to specific environments. First, we need to make a new environment for our project. The following command will create a new empty environment called `I590-term-project`.

`conda create --name I590-term-project`

In order to install packages and do stuff in that environment, we need to activate it in a similar we we activated the base environment.

`conda activate I590-term-project`

Finally, we can install Snakemake (and eventually, other packages we might need).

`conda install -y -c conda-forge -c bioconda snakemake`

This will install Snakemake, all of its dependencies, and a new, isolated python command specific to the `I590-term-project` environment and might take a minute or two. I know this seems like an awful lot of work but it will allow our results to be reproducable with a single command later on.
