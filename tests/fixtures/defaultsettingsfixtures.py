import json

import pytest
from elementalcms import ElementalContext
from elementalcms.core import FlaskContext, MongoDbContext


@pytest.fixture
def default_settings():
    with open('settings/default.json') as settings_as_json:
        return json.load(settings_as_json)


@pytest.fixture
def default_elemental_context(default_settings) -> ElementalContext:
    return ElementalContext(FlaskContext(default_settings.get('cmsCoreContext', {})),
                            MongoDbContext(default_settings.get('cmsDbContext', {})))
