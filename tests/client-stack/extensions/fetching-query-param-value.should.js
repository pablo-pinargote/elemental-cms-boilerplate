/**
 * @jest-environment jsdom
 **/

import {QueryString} from "../../../src/static/app/client-stack/extensions/window.js";

describe('Fetching query param value', () => {

    it('should return undefined when url is parameterless', () => {
        window.history.replaceState({}, 'Testing query string', '?');
        let result = new QueryString().getValue('test');
        expect(result).toBe(undefined);
    });

    it('should be equal to default value when url is parameterless', () => {
        window.history.replaceState({}, 'Testing query string', '?');
        let result = new QueryString().getValue('name', 'my-name');
        expect(result).toBe('my-name');
    });

    it('should be equal to default value when param does not exist', () => {
        window.history.replaceState({}, 'Testing query string', '?test=yes');
        let result = new QueryString().getValue('name', '');
        expect(result).toBe('');
    });

    it('should be equal to yes', () => {
        window.history.replaceState({}, 'Testing query string', '?test=yes');
        let result = new QueryString().getValue('test');
        expect(result).toBe('yes');
    });

});