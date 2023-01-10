#!/usr/bin/env bash

echo -e "\\usepackage{fvextra}\n\\DefineVerbatimEnvironment{Highlighting}{Verbatim}{breaklines,commandchars=\\\\\\\\\\{\\}}" > config.yaml
pandoc "$1".md \
		-H config.yaml \
		-s --highlight-style tango \
		--pdf-engine=xelatex \
		--toc \
		-o "$1".pdf
rm config.yaml
echo -e "\n\nConversion Finished !!!"
