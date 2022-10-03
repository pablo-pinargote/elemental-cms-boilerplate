from elementalcms import Elemental, ElementalContext
from flask import Flask


def create_app(elemental_context: ElementalContext):

    app = Flask(__name__, template_folder='templates', static_folder=elemental_context.cms_core_context.STATIC_FOLDER)

    Elemental(app,
              elemental_context)

    return app
