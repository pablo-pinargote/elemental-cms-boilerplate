/**
 * @jest-environment jsdom
 **/

import {QueryString} from "../../../src/static/shared/client-stack/extensions/window.js";

describe('Fetching query string', () => {

    it('should return empty string when url is parameterless', () => {
        window.history.replaceState({}, 'Testing query string', '?');
        let result = new QueryString().get();
        expect(result).toBe('');
    });

    it('should be equal to test=yes', () => {
        window.history.replaceState({}, 'Testing query string', '?test=yes');
        let result = new QueryString().get();
        expect(result).toBe('test=yes');
    });

});