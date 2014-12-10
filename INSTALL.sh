#!/bin/bash

echo create a python virtual env...
virtualenv -p `which python2` pyvirtualenv || exit 1

source pyvirtualenv/bin/activate

echo install requirements packages...
tar xf packages.tar.gz
pushd packages/

pip install django/Django-1.3.7.tar.gz
# celery
pip install djcelery/amqp-1.0.13.tar.gz
pip install djcelery/anyjson-0.3.3.tar.gz
pip install djcelery/kombu-2.5.16.tar.gz
pip install djcelery/pytz-2014.10-py2.py3-none-any.whl
pip install djcelery/python-dateutil-1.5.tar.gz
pip install djcelery/billiard-3.3.0.19.tar.gz
pip install djcelery/celery-3.0.0.tar.gz
pip install djcelery/django-celery-3.0.0.tar.gz
pip install djcelery/django-kombu-0.9.4.tar.gz

# redis
pip install redis/redis-2.4.10.tar.gz

# django
pip install django/django-addons-0.6.6.tar.gz
pip install django/django-notification-0.1.5.zip
pip install django/django-bulk-0.1devel.zip
pip install django/django-tagging-0.4.dev1.zip
pip install django/django-tagging-autocomplete-0.3.1.tar.gz

pip install django/django-authority-0.5.tar.gz

pip install django/PIL-1.1.7.tar.gz
pip install django/Pillow-2.6.1.tar.gz
pip install django/easy-thumbnails-1.2.tar.gz
pip install django/html2text-2014.12.5.tar.gz
pip install django/six-1.8.0-py2.py3-none-any.whl
pip install django/django-guardian-1.2.4.tar.gz
pip install django/django-userena-1.2.0.tar.gz

pip install django/South-0.7.3.tar.gz
pip install django/django_appconf-0.6-py2.py3-none-any.whl
pip install django/django-compressor-1.2a1.zip

pip install django/httplib2-0.9.tar.gz
pip install django/oauth2-1.5.211.tar.gz
pip install django/python-openid-2.2.5.zip
pip install django/django-social-auth-0.7.28.tar.gz

pip install django/django-haystack-2.0.0-beta.zip
pip install django/django-threadedcomments-0.9.tar.gz
pip install django/django-ajax-selects-1.1.4.tar.gz
pip install django/contact_form-0.3.tar.gz
pip install django/django-piston-0.2.3.tar.gz
pip install django/django-pagination-1.0.7.zip
pip install django/django-sorting-0.1.tar.gz
pip install django/django-filter-0.5.4.tar.gz

pip install django/hiredis-0.1.5.tar.gz
pip install django/polib-0.6.3.tar.gz
pip install django/pygooglechart-0.4.0.tar.gz
pip install django/requests-2.5.0-py2.py3-none-any.whl
pip install django/pysolr-3.2.0-py2.py3-none-any.whl
pip install django/BeautifulSoup-3.2.0.tar.gz
pip install django/userprofile-0.7-r422-correct-validation.tar.gz

pip install django/django-staticfiles-1.2.1.tar.gz
pip install django/django-picklefield-0.3.1.tar.gz

# others
pip install others/chardet-2.3.0.tar.gz
pip install others/python-Levenshtein-0.11.2.tar.gz
pip install others/Markdown-2.5.2.tar.gz

popd
rm -rf packages

pushd transifex
echo Create directories '/var/lib/transifex' .........
sudo mkdir -p /var/lib/transifex
sudo chmod -R 777 /var/lib/transifex
python2 ./manage.py txcreatedirs        # Create necessary directories
python2 ./manage.py syncdb              # Setup DB tables, create superuser
python2 ./manage.py migrate             # Setup more DB tables
python2 ./manage.py txlanguages         # Create a standard set of languages
python2 ./manage.py txcreatenoticetypes # Create a standard set of notice types
python2 ./manage.py collectstatic       # Copy all the app static files to the static dir
python2 ./manage.py compilemessages     # Comile .po files to .mo

echo Install finished
python2 ./manage.py runserver 0.0.0.0:8000
popd
