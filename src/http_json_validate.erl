-module(http_json_validate).

-export([validate/2]).


validate(<<"/decode">>, Body) ->
    Schema = #{
        date => [required, string]
    },
    liver:validate(Schema, Body).