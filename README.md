# WebkitOnDocker
This is the development environment for compiling Webkit for AmigaOS 4

To compile Odyssey Web Browser v2 you need to do the following:

```
git clone https://github.com/walkero-gr/OdysseyWebBrowser.git --depth 1 -b compile-owb-w.-2.24.4
docker run -it --rm -v ${PWD}/OdysseyWebBrowser:/opt/OdysseyWebBrowser -w /opt/OdysseyWebBrowser walkero/webkitondocker:2.1 makefile -f os4.Makefile all
```