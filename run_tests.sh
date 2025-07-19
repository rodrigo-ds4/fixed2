#!/bin/bash
python -m twisted.trial     --reporter=verbose     --tbformat=verbose     --no-recurse     --without-module=twisted.internet.asyncioreactor     --without-module=twisted.internet.gireactor     --without-module=twisted.internet.gtk3reactor     --without-module=twisted.internet.pyuireactor     --without-module=twisted.internet.wxreactor     src/twisted/web/test/test_xml.py     src/twisted/web/test/test_domhelpers.py
exit $?
