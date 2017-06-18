FROM ubuntu:16.04
MAINTAINER piotrekolchawa@gmail.com

RUN apt-get update && apt-get install -y \
  build-essential \
  sudo \
  zsh \
  nodejs \
  vim \
  git \
  curl \
  libssl-dev libreadline-dev zlib1g-dev # Ruby depenencies

# Set ZSH as default shell
ENV TERM xterm-256color
# Create application directory
RUN useradd --create-home -s /usr/bin/zsh peter && echo 'peter:password1234' | chpasswd && usermod -aG sudo peter
# Install ruby form newly created user
SHELL ["zsh", "-c"]
USER peter
WORKDIR /home/peter
# Install oh-my-zsh
RUN curl -fsSL https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | zsh || true
# Download configuration files
RUN git clone https://github.com/2easy/vimzshconf tconf && mv tconf/.* . && rm -rf .git/ tconf/
# Install rbenv and ruby
RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv
RUN cd ~/.rbenv && src/configure && make -C src &&\
    git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build &&\
    cd ~ && source .zshrc && rbenv install 2.4.1 && rbenv global 2.4.1 && gem install bundler

CMD ["/usr/bin/zsh"]
