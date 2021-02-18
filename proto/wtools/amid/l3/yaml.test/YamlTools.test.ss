( function _YamlTools_test_ss_( )
{

'use strict';

if( typeof module !== 'undefined' )
{
  let _ = require( '../../../../wtools/Tools.s' );
  _.include( 'wTesting' );
  require( '../yaml/include/Mid.s' );
}

//

let _ = _global_.wTools;

// --
// context
// --

function onSuiteBegin( test )
{
  let context = this;
  context.provider = _.fileProvider;
  let path = context.provider.path;
  context.suiteTempPath = context.provider.path.tempOpen( path.join( __dirname, '../..' ), 'YamlTools' );
  context.suiteTempPath = context.provider.pathResolveLinkFull({ filePath : context.suiteTempPath, resolvingSoftLink : 1 });
  context.suiteTempPath = context.suiteTempPath.absolutePath;

}

//

function onSuiteEnd( test )
{
  let context = this;
  let path = context.provider.path;
  _.assert( _.strHas( context.suiteTempPath, 'YamlTools' ), context.suiteTempPath );
  path.tempClose( context.suiteTempPath );
}

// --
// tests
// --

function trivial( test )
{

  var src =
`

about :
  name : some name
  version : 0.0.0

path :
  in : .
  out : out

`

  var exp =
  {
    'line' : '  in : .',
    'head' : '  ',
  }
  var got = _.yaml.lineFind( src, 'in' );
  test.contains( got, exp );

}

// --
// declare
// --

var Proto =
{

  name : 'Tools.mid.YamlTools',
  silencing : 1,

  onSuiteBegin,
  onSuiteEnd,

  context :
  {
    provider : null,
    suiteTempPath : null,
  },

  tests :
  {
    trivial,
  },

}

//

let Self = new wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
