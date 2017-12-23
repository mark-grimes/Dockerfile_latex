# Latex docker image

This is an image as small as I could make for creating latex documents. Depending on your project
there's a good chance it will be missing something you need, in which case use
`tlmgr install <package>` to install your requirements.

It uses the texlive installer directly because I couldn't find an OS package that was a respectable
size - even basic installations came out at 600Mb or so (full was 1.5Gb).

## Running
The workdir is set as `/project`, so if you share your project directory to there you can run with
e.g.:
```
docker run --rm -v $PWD:/project markgrimes/latex pdflatex mydocument.tex
```


If you need to install packages then the default command is a shell, so you can e.g.
```
docker run --name mylatexshell -it -v $PWD:/project markgrimes/latex
```


Then inside the container:
```
tlmgr install package1 package2 package3
pdflatex mydocument.tex
```
