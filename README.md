# @endeo/types
[![Build Status](https://travis-ci.org/elidoran/endeo-types.svg?branch=master)](https://travis-ci.org/elidoran/endeo-types)
[![Dependency Status](https://gemnasium.com/elidoran/endeo-types.png)](https://gemnasium.com/elidoran/endeo-types)
[![npm version](https://badge.fury.io/js/%40endeo%2Ftypes.svg)](http://badge.fury.io/js/%40endeo%2F/types)

Common types for values in @endeo/specials objects.

These are used when creating an "object spec" to encode a "special object" in a compressed format. They are specified as the 'type' in the `enhancers` object.

When endeo's enbyte encodes a "special object" it must test each key's value to determine which type it is so it knows how to encode it. Specify its exact type to skip that work.

See packages:

1. [endeo](https://www.npmjs.com/package/endeo)
2. [enbyte](https://www.npmjs.com/package/enbyte)
3. [debyte](https://www.npmjs.com/package/debyte)


## Install

```sh
npm install --save @endeo/types
```


## Usage


```javascript
var types = require('@endeo/types')

var enhancers = {
  key: {
    type: types.day
  }
}

// OR, when specials has the type
specials.addType('day', types.day)

var enhancers = {
  key: 'day'
}
```


## Extra Types

There are two extra types available for optional use:

1. **day** - A `Date` requires many bytes to encode because it has a lot of info. If you only want to store the year, month, and day (in month) then you may use this type and it'll encode it in four bytes instead.
2. **time** - As mentioned above, a `Date` requires many bytes. If you only want the hours and minutes (24-hour style) then use this type to encode it in two bytes.


# [MIT License](LICENSE)
