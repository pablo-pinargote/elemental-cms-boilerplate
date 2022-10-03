# Extract translations to template
pybabel extract -F babel.cfg -o messages.pot .

# Init especific language translations in "translations" folder
pybabel init -i messages.pot -d translations -l es

# Update all translations in "translations" folders
pybabel update -i messages.pot -d translations

# Compile translations on "translations" folder
pybabel compile -d translations