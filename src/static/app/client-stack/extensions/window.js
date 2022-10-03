class QueryString {

    constructor() {
        let self = this;
        self.map = {};
        window.location.search.substring(1).split('&').forEach(function (queryValuePair) {
            let parts = queryValuePair.split('=');
            if (parts.length !== 2) return;
            self.map[parts[0].toString()] = parts[1].toString();
        });
    };

    get() {
        return window.location.search.substring(1);
    }

    getValue(name, defaultValue=undefined) {
        let self = this;
        if (name in self.map) return self.map[name];
        if (defaultValue === undefined) return defaultValue;
        return defaultValue;
    };

    hasParam(name) {
        return name in this.map;
    }

}

let queryString = new QueryString();
export {queryString};
