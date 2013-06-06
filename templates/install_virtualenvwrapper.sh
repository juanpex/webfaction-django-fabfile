# First, set your python version. I assume python2.7 in this example.
PYTHONVER=2.7
PIPVERSION=3.6
# Install virtualenv and virtualenvwrapper
PYTHON=python${PYTHONVER}
mkdir -p $HOME/{bin,tmp,lib/$PYTHON,src}
easy_install-${PYTHONVER} pip
pip-${PYTHONVER} install virtualenv

cd $HOME/src
wget 'http://pypi.python.org/packages/source/v/virtualenvwrapper/virtualenvwrapper-${PIPVERSION}.tar.gz'
tar -xzf virtualenvwrapper-${PIPVERSION}.tar.gz
cd virtualenvwrapper-${PIPVERSION}
PYTHONPATH=$HOME/lib/$PYTHON $PYTHON setup.py install --home=$HOME

# Update $HOME/.bashrc with appropriate environment variables
echo 'export PATH="$HOME/bin:$PATH"' >> $HOME/.bashrc
echo 'export TEMP="$HOME/tmp"' >> $HOME/.bashrc
echo "alias python=${PYTHON}" >> $HOME/.bashrc
echo "export PYTHON=${PYTHON}" >> $HOME/.bashrc
echo 'export WORKON_HOME="$HOME/.virtualenvs"' >> $HOME/.bashrc
echo 'export VIRTUALENVWRAPPER_TMPDIR="$WORKON_HOME/tmp"' >> $HOME/.bashrc
echo "export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/$PYTHON" >> $HOME/.bashrc
echo 'source $HOME/bin/virtualenvwrapper.sh' >> $HOME/.bashrc
echo 'export PIP_VIRTUALENV_BASE=$WORKON_HOME' >> $HOME/.bashrc
echo 'export PIP_RESPECT_VIRTUALENV=true' >> $HOME/.bashrc

# load these changes
source $HOME/.bashrc
hash -r
