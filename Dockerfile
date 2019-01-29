FROM swipl:latest AS build

RUN apt-get update \
 && apt-get install --no-install-recommends -y \
    wget \
    unzip \
    make \
    g++ \
    patch \
    dos2unix \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /bee

COPY fix-load_foreign_library.patch .

RUN wget http://amit.metodi.me/research/bee/bee20170615.zip \
 && unzip bee20170615.zip

RUN tar xf satsolver_src/plSATsolver.tar.gz -C satsolver \
 && tar xf satsolver_src/plGlucose4_src.tar.gz -C satsolver

RUN (cd satsolver/prologinterface \
 &&  swipl --dump-runtime-variables | sed s/=\"/=/g | sed s/\"\;//g > SETTINGS \
 &&  make ) \
 && mv satsolver/prologinterface/pl-glucose4.so satsolver/pl-glucose4.so \
 && rm -rf satsolver/glucose-4 satsolver/prologinterface

RUN (cd beeSolver \
 &&  dos2unix satSolverInterface.pl \
 &&  patch -p0 satSolverInterface.pl < ../fix-load_foreign_library.patch \
 &&  make)


FROM swipl:latest

LABEL maintainer="Konstantin Chukharev lipen00@gmail.com"

COPY --from=build /bee/BumbleBEE /bee/BumbleSol /usr/bin/
COPY --from=build /bee/pl-satsolver.so /usr/lib/

WORKDIR /input
ENTRYPOINT ["/usr/bin/BumbleBEE"]
