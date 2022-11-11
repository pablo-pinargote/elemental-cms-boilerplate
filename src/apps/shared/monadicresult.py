class MonadicResult(object):

    def is_failure(self):
        raise Exception("is_failure method needs to be implemented")

    def is_no_result(self):
        raise Exception("is_no_result method needs to be implemented")

    def is_access_denied(self):
        raise Exception("is_access_denied method needs to be implemented")

    def value(self):
        raise Exception("is_failure method needs to be implemented")


class Failure(MonadicResult):
    def __init__(self, v=None): self.v = v
    def is_failure(self): return True
    def value(self): return self.v
    def is_no_result(self): return False
    def is_access_denied(self): return False


class AccessDenied(Failure):
    def __init__(self):
        super().__init__(None)

    def is_access_denied(self): return True


class NoResult(Failure):
    def __init__(self):
        super().__init__(None)

    def is_no_result(self): return True


class Success(MonadicResult):
    def __init__(self, v = None): self.v = v
    def is_failure(self): return False
    def value(self): return self.v
