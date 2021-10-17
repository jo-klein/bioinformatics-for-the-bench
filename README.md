# compbio-tools-for-the-bench
Computational biology tools for bench scientists who are new to Python and bash scripting

This repo contains computational biology tools for common tasks in biology research. They are short well-commented scripts that I've written to support my research activities. The scripts are primarily focused on enabling the expert bench researcher to generate and manipulate nucleic acid sequences as well as prepare, execute, and analyze NGS experiments from start to finish (while learning some Python in the process).

The scripts are run from the command line in Terminal (Mac, PC, Linux). If this is new to you, don't worry. I've written a simple guide (see GETTING_STARTED.txt) that will get you up an running in 30 minutes or less even if you've never used the command line before. All of the Python (.py) and bash (.sh) scripts are run as follows:

1. Open your preferred command line terminal application.
2. Navigate to the location of the script.
3. At the command line prompt (using ">" below as an example) enter the following and press enter:

    > name_of_the_script.ext argument_1 argument_2 argument_3 ... argument_n

The "arguments" could be DNA sequences, chromosome coordinates, or some customizable options you want to tell the script to use. Just read the script header for instructions.

Many of the tools rely on tools that others have created called "dependencies" that will be listed in the script headers or the import sections below them. If you've already learned how to use pip or conda or you've already read GETTING_STARTED.txt, then you know what to do.

Feel free to use, modify, repurpose, and stitch them together with others to make the scripts you need. I enjoy coding for fun. If you need a simple script that isn't here or elsewhere, let me know and I'll give it a try if I have the time!
