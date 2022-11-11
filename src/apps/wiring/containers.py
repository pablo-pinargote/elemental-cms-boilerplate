from dependency_injector import containers, providers


class Containers(containers.DeclarativeContainer):

    config = providers.Configuration()
