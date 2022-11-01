/**
 * @jest-environment jsdom
 **/

import {QueryString} from '../../../src/static/app/client-stack/extensions/window.js';

describe('Verifiyng query string param existence', () => {

    it('should return false for missing param', () => {
        window.history.replaceState({}, 'Testing query string', '?myparam=ok');
        let result = new QueryString().hasParam('test');
        expect(result).toBe(false)
    });

    it('should return true for "test" param', () => {
        window.history.replaceState({}, 'Testing query string', '?test=ok');
        let result = new QueryString().hasParam('test');
        expect(result).toBe(true)
    });

});
