FROM jenkins
USER root

# �� shell �滻Ϊ bash
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# �����пƴ��������Դ
RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
RUN sed -i 's|security.debian.org|mirrors.ustc.edu.cn/debian-security|g' /etc/apt/sources.list
# upgrade
RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y apt-utils sudo 

# ��װ dotnet core SDK
RUN apt-get install -y curl libunwind8 gettext \
    && curl -sSL -o dotnet.tar.gz https://go.microsoft.com/fwlink/?linkid=847105\
    && mkdir -p /opt/dotnet && tar zxf dotnet.tar.gz -C /opt/dotnet \
    && ln -s /opt/dotnet/dotnet /usr/local/bin

USER root
# ��װ yarn
RUN curl -sS http://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - -y
RUN echo "deb http://dl.yarnpkg.com/debian/ stable main" |  tee /etc/apt/sources.list.d/yarn.list

# ��װһЩ��Ҫ�Ĺ���
RUN apt-get update \
    && apt-get install -y openjdk-8-jdk yarn build-essential

# ʹ jenkins ���� docker ����Ҫ sudo
RUN groupadd -o -g 999 docker && usermod -aG docker jenkins

RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers


USER jenkins
# ���ʱ������
ENV JAVA_OPTS -Duser.timezone=Asia/Shanghai

RUN touch ~/.bashrc

ENV NVM_NODEJS_ORG_MIRROR https://mirrors.ustc.edu.cn/node
ENV NODE_VERSION v7.9.0
# ��װ nvm �� node
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash \
    && bash ~/.nvm/nvm.sh \
    && bash -c "source ~/.nvm/nvm.sh \
    && nvm install $NODE_VERSION \
    &&  nvm use $NODE_VERSION"

# ���� npm ���Ա�����
RUN echo "registry=https://registry.npm.taobao.org" > ~/.npmrc