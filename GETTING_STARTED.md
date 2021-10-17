This tutorial will lead you through five steps, which together are sufficient for one to use some of the scripts in this repository as well as process and analyze a DNA-seq data set. It assumes you've already reviewed the README.txt, which is recommended before starting this tutorial.

To run nearly all of the scripts in this reposity, one will need a package manager already installed. Package managers are critical pieces of software that will find and install the software packages needed in order run certain scripts. These supporting software packages are often referred to as "dependencies."

An internet service provider is a useful analogy for a package manager. The provider sits between your computer and the rest of the internet. If you want to access a web page, you enter the URL in your browser, and the provider then communicates with various servers on the internet to make sure it delivers the correct webpage. A package manager basically does the same thing. It sits between your computer and the servers housing the respositories where the packages you want are stored and (usually) selects the correct package and version when you ask it to install one. However, some package managers perform other important functions as well:

1. It checks the versions of all of the currently installed packages to select only a compatible package version for installation. This can fail if there is no compatible package, if you haven't told the manager to include the required repository in its search, or if the author of a package didn't document its requirements accurately. Luckily, the package manager will usually identify which currently installed package(s) is incompatible.

2. It will install or upgrade/downgrade additional dependencies for the requested package if they aren't already installed.

3. When uninstalling a package, it will (often) either uninstall the dependencies that came with it or roll back the versions of the dependencies to what they were before the package was installed.

4. This final item is very important: accidents happen when working with lots of dependencies. A good package manager will allow one to create multiple and completely separated workspaces, which are called "virtual environments." For example, one might have a virtual environment called dna-seq and another one called rna-seq. Imagine that you're working in the dna-seq environment and you install a package that breaks your environment; you might end up having to rebuild it from scratch, but at least the rna-seq environment will remain unaffected. You may also find this useful for versioning environments. For example, you may have a basic dna-seq environment and want to test some customizations. To be safe, you might opt to clone your dna-seq environment so that if your customizations cause trouble, you can delete that cloned environment and just go back to your original dna-seq environment.

Ok, that's enough reading, now let's get to doing!

There a multiple package managers such as pip, homebrew, anaconda, and miniconda. I happen to like miniconda, so that's what we're using here. So:

1. Download and install miniconda from https://docs.conda.io/en/latest/miniconda.html. These are available as binaries that step  through installation after you double-click on the downloaded package. Select a location where you would like your miniconda installation to reside. Many just set it to their home directories. During installation, the path to its location will typically be added to a specific file such as ~/.bash_profile in OS X. That means you can call packages from any folder in your computer. It also means that if you move your installation and don't update .bash_profile, your installation will automagically stop working.

2. Open your terminal app and type the following and press enter (I don't know why the command starts with "conda" instead of "miniconda"):
   > conda create -n dna-seq python=3.7
   
   > conda activate dna-seq
   
Congratulations! You've just created your first virtual environment, named it dna-seq, and told conda to create it using Python version 3.7. There are many other versions to select from -- this is just the one I use most often. You've also activated the dna-seq environment, so any changes you make here (or mistakes you can't fix) won't be reflected in your default environment. 

Note that the terminal command line prompt now reads "dna-seq." When ready to exit the dna-seq virtual environment, just enter "conda deactivate" and now the prompt will read "base," which means it's returned to the default environment.

3. Next, we'll add bioconda as one of the channels that conda will use when searching for packages. Many of the packages you'll find useful will reside there. Type the following and press enter:

   > conda config --env --add channels bioconda
   
4. Now let's install some packages that you are likely to be using at some point. For now, we'll just let conda choose the versions it thinks are best. Install each of the packages below by typing (without quotes) "conda install [package name]" and pressing enter. You can also type "conda install [package name 1] [package name 2] [package name 2] ... [package name n]" and press enter to install them all at once, but we're going one step at a time for the sake of learning. The package list:
> numpy

Adds math functionality beyond the basics that come with Python.

https://numpy.org/

> pandas

Powerful tool set for organizing, querying, and manipulating arrays of data. 

https://pandas.pydata.org/

> lxml

Enables working with XML data such as when fetching reference genome sequences from the UCSC Genome Browser. 

https://lxml.de/

> fastqc

Creates a quality control report on the raw fastq data file output by bcl2fastq from an NGS run. Bcl2fastq is typically automatically run in BaseSpace assuming you're working with Illumina data so that you can just download the fastq files to your computer.

https://www.bioinformatics.babraham.ac.uk/projects/fastqc/

> multiqc

Combines multiple fastqc reports such as what you would get from a paired end run into one concise report.

https://multiqc.info/

> cutadapt

Removes adapters, primers, and poly-A tails from your raw fastq output files as well as demultiplexes your barcodes if desired.

https://cutadapt.readthedocs.io/en/stable/guide.html

> trim_galore

Uses cutadapt to automate its functions and also automatically detects common adapter sequences, trims low quality reads, and other quality control tasks to output fastq files that are ready for alignment to a reference genome.

https://www.bioinformatics.babraham.ac.uk/projects/trim_galore/

> bwa-mem

Commonly used aligner for aligning NGS reads in fastq files to a reference genome.

http://bio-bwa.sourceforge.net/

> samtools

A collection of tools for converting the alignment output BAM file into a file that can be viewed by Integrated Genome Browser and other analysis software as well as performing many basic NGS analysis functions.

http://www.htslib.org/

Ok, so now you've installed the essential tools for running Python scripts as well as processing, analyzing, and manipulating NGS data. What next? How about processing a DNA-seq data set? Follow the NGS_PRACTICE_ANALYSIS.txt tutorial or take off in your own direction!
    
