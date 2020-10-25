FROM debian:latest

RUN apt-get update -y && \
	apt-get install -y apt-utils \
		default-jre \
		default-jdk \
		ant \
		unzip \
		bsdtar \
		wget \
		git

RUN export REL_DATE=""; \
	mkdir CoreNLP; \
	cd CoreNLP; \
	wget http://nlp.stanford.edu/software/stanford-corenlp-latest.zip; \
	bsdtar --strip-components=1 -xvf stanford-corenlp-latest.zip; \
	rm stanford-corenlp-latest.zip; \
	export CLASSPATH=""; for file in `find . -name "*.jar"`; do export CLASSPATH="$CLASSPATH:`realpath $file`"; done

ENV PORT 9000

EXPOSE 9000

WORKDIR CoreNLP

CMD java -cp '*' -mx4g edu.stanford.nlp.pipeline.StanfordCoreNLPServer

