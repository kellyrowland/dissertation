all: thesis

front_len = 10
abstract_page = 3

abstract:
	@latex -interaction=batchmode thesis
	@latex -interaction=batchmode -jobname=abs "\includeonly{abstract}\input{thesis}"
	@biber --quiet abs
	@latex -interaction=batchmode -jobname=abs "\includeonly{abstract}\input{thesis}"
	@pdflatex -interaction=batchmode -jobname=abs "\includeonly{abstract}\input{thesis}"
	@pdftk abs.pdf cat $(abstract_page) output abstract.pdf
	@rm abs.*
	@make clean > /dev/null
	@chmod 777 abstract.pdf
	@mv abstract.pdf pdf

intro:
	@latex -interaction=batchmode thesis
	@latex -interaction=batchmode -jobname=int "\includeonly{intro}\input{thesis}"
	@biber --quiet int
	@latex -interaction=batchmode -jobname=int "\includeonly{intro}\input{thesis}"
	@pdflatex -interaction=batchmode -jobname=int "\includeonly{intro}\input{thesis}"
	@pdftk int.pdf cat $(front_len)-end output intro.pdf
	@rm int.*
	@make clean > /dev/null
	@chmod 777 intro.pdf
	@mv intro.pdf pdf

bg:
	@latex -interaction=batchmode thesis
	@latex -interaction=batchmode -jobname=bgr "\includeonly{background}\input{thesis}"
	@biber --quiet bgr
	@latex -interaction=batchmode -jobname=bgr "\includeonly{background}\input{thesis}"
	@pdflatex -interaction=batchmode -jobname=bgr "\includeonly{background}\input{thesis}"
	@pdftk bgr.pdf cat $(front_len)-end output bg.pdf
	@rm bgr.*
	@make clean > /dev/null
	@chmod 777 bg.pdf
	@mv bg.pdf pdf

method:
	@latex -interaction=batchmode thesis
	@latex -interaction=batchmode -jobname=mthd "\includeonly{method}\input{thesis}"
	@biber --quiet mthd
	@latex -interaction=batchmode -jobname=mthd "\includeonly{method}\input{thesis}"
	@pdflatex -interaction=batchmode -jobname=mthd "\includeonly{method}\input{thesis}"
	@pdftk mthd.pdf cat $(front_len)-end output method.pdf
	@rm mthd.*
	@make clean > /dev/null
	@chmod 777 method.pdf
	@mv method.pdf pdf

results:
	@latex  -interaction=batchmode thesis
	@latex  -interaction=batchmode -jobname=rslt "\includeonly{results}\input{thesis}"
	@biber --quiet rslt
	@latex  -interaction=batchmode -jobname=rslt "\includeonly{results}\input{thesis}"
	@pdflatex -interaction=batchmode -jobname=rslt "\includeonly{results}\input{thesis}"
	@pdftk rslt.pdf cat $(front_len)-end output results.pdf
	@rm rslt.*
	@make clean > /dev/null
	@chmod 777 results.pdf
	@mv results.pdf pdf

conclusion:
	@latex -interaction=batchmode thesis
	@latex -interaction=batchmode -jobname=cnc "\includeonly{conclusion}\input{thesis}"
	@biber --quiet cnc
	@latex -interaction=batchmode -jobname=cnc "\includeonly{conclusion}\input{thesis}"
	@pdflatex -interaction=batchmode -jobname=cnc "\includeonly{conclusion}\input{thesis}"
	@pdftk cnc.pdf cat $(front_len)-end output conclusion.pdf
	@rm cnc.*
	@make clean > /dev/null
	@chmod 777 conclusion.pdf
	@mv conclusion.pdf pdf

thesis:
	@latex -interaction=batchmode thesis
	@biber --quiet thesis
	@latex -interaction=batchmode thesis
	@pdflatex -interaction=batchmode thesis
	@make clean > /dev/null
	@chmod 777 thesis.pdf
	@mv thesis.pdf pdf

current_dir = $(shell pwd)

dock:
	@docker pull kellyrowland/docker-texlive
	@docker run -v $(current_dir):/doc/ \
        -t -i kellyrowland/docker-texlive

dock-local:
	@docker run -v $(current_dir):/doc/ \
        -t -i kellyrowland/docker-texlive

clean:
	@rm -f *.aux \
           *.bbl \
           *.bcf \
           *.blg \
           *.dvi \
           *.lof \
           *.log \
           *.lot \
           *.out \
           *.toc \
	       *.run.xml
	@find img -name "*-converted-to.pdf" -type f -delete
