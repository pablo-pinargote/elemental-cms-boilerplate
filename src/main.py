import json
import os

import requests
from elementalcms import ElementalContext
from elementalcms.core import FlaskContext, MongoDbContext
from flask import render_template, send_from_directory, make_response

from __init__ import create_app


CONFIG_FILEPATH = os.environ.get('CONFIG_FILEPATH')

with open(CONFIG_FILEPATH) as config_file:
    settings = json.load(config_file)
    cms_core_context = FlaskContext(settings['cmsCoreContext'])
    cms_db_context = MongoDbContext(settings['cmsDbContext'])
    elemental_context = ElementalContext(cms_core_context, cms_db_context)

www, containers = create_app(elemental_context)


@www.errorhandler(404)
def page_not_found(e):
    return render_template('404.html'), 404


@www.errorhandler(500)
def internal_error(e):
    return render_template('500.html'), 500


@www.route('/robots.txt')
def robots():
    return send_from_directory(www.template_folder, 'robots.txt')


@www.route('/progressive/manifest.json')
def get_drive_app_manifest():
    if 'http' in elemental_context.cms_core_context.STATIC_URL:
        response = requests.get(f'{elemental_context.cms_core_context.STATIC_URL}/apps/progressive/pwa/manifest.json', timeout=30)
        return response.text, response.status_code, response.headers.items()
    response = make_response(
        send_from_directory('static/apps/progressive/pwa', 'manifest.json'))
    return response


@www.route('/progressive/sw.js')
def get_drive_app_service_worker():
    if 'http' in elemental_context.cms_core_context.STATIC_URL:
        response = requests.get(f'{elemental_context.cms_core_context.STATIC_URL}/apps/progressive/pwa/sw.js', timeout=30)
        return response.text, response.status_code, response.headers.items()

    response = make_response(
        send_from_directory('static/apps/progressive/pwa', 'sw.js'))
    # change the content header file. Can also omit; flask will handle correctly.
    response.headers['Content-Type'] = 'application/javascript'
    return response


if __name__ == '__main__':
    www.run(host='0.0.0.0', port=8010, debug=elemental_context.cms_core_context.DEBUG)
