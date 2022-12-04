# Elemental CMS Boilerplate

This boilerplate will guide you through the use and common scenarios when building a web application using Elemental CMS.

## The Docs

Official documentation about the tool can be found at https://paranoid.software/elemental-cms/docs

## At this repo

This repo try to illustrate the implementation of the following ideas / strategies:

- Using terraform  with Azure DevOps and GCP
- Using npm as javascript package manager
- Using pytest for python testing environment
- Using Jest for javascript testing environment
- Using bulma as CSS framework
- Enabling PWA support

### Using terraform  with Azure DevOps and GCP

TBD

### npm as javascript package manager

TBD

### Using pytest for python testing environment

TBD

### Using Jest for javascript testing environment

TBD

### Using bulma as CSS framework

TBD

### Enabling PWA support

This project can serve more than one PWA, to activate any specific page as such we must include the following files and/or gimmicks:

1. Add a "fake" manifest.json file route at flask application

    ```python
    @www.route('/progressive/manifest.json')
    def get_drive_app_manifest():
        if 'http' in elemental_context.cms_core_context.STATIC_URL:
            response = requests.get(f'{elemental_context.cms_core_context.STATIC_URL}/apps/progressive/pwa/manifest.json', timeout=30)
            return response.text, response.status_code, response.headers.items()
        response = make_response(
            send_from_directory('static/apps/progressive/pwa', 'manifest.json'))
        return response
    ```

2. Add a "fake" sw.js script file route at flask application

    ```python
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
    ```

3. Add a new template to include and serve the intended manifest.json file via meta tag and init script via its corresponding script tag

   ```html
   <html>
   <head>
       {% block meta %}{% endblock %}
       
       <link rel="canonical" href="{{ config['CANONICAL_URL'] }}">
       
       <!--suppress HtmlUnknownTarget -->
       <link rel="manifest" href="/progressive/manifest.json">
       
       <link rel="shortcut icon" type="image/png" href="{{ elemental_url_for_static('shared/icons/favicon.ico') }}"/>
   </head>   
   <body>
    <script type="application/javascript">
       window.addEventListener('load', function () {
   
           if (!('serviceWorker' in navigator)) {
               console.log('Service Worker not supported !');
               return;
           }
   
           navigator.serviceWorker.register('/progressive/sw.js').then(function (registration) {
               console.log(`Service Worker registration with ${registration.scope} scope successful`);
           }, function (err) {
               console.log(`Service Worker registration failed with error: ${err}`);
           });
   
       });
    </script>
   </body>
   ```

4. Add the following files inside a new app folder located ad static/apps/<app-name>/pwa

    - manifest.json
    - sw.js
    - init.js
    
5. Add icons for PWA at folder static/apps/<app-name>/icons

6. Assign the new template for the page/s that will form part of the progressive web application
