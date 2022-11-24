from elementalcms import Elemental, ElementalContext
from flask import Flask


from apps.wiring import Containers


def create_app(elemental_context: ElementalContext):

    app = Flask(__name__, template_folder='templates', static_folder=elemental_context.cms_core_context.STATIC_FOLDER)

    app.containers = Containers()
    # default.containers.config.<my_config>.from_value(<my_config>)
    app.containers.init_resources()
    app.containers.wire(packages=['apps'])

    Elemental(app,
              elemental_context)

    # csrf = CSRFProtect(default)

    return app, app.containers
