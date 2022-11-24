export class QueryString {

    constructor() {
    }

    get() {
        return window.location.search.substring(1);
    }

    getValue(name, defaultValue=undefined) {
        return new URL(window.location).searchParams.get(name) || defaultValue;
    };

    hasParam(name) {
        return Array.from(new URL(window.location).searchParams.keys()).includes(name);
    }

}
