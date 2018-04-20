using ReactNative.Bridge;
using System;
using System.Collections.Generic;
using Windows.ApplicationModel.Core;
using Windows.UI.Core;

namespace Smartconnection.RNSmartconnection
{
    /// <summary>
    /// A module that allows JS to share data.
    /// </summary>
    class RNSmartconnectionModule : NativeModuleBase
    {
        /// <summary>
        /// Instantiates the <see cref="RNSmartconnectionModule"/>.
        /// </summary>
        internal RNSmartconnectionModule()
        {

        }

        /// <summary>
        /// The name of the native module.
        /// </summary>
        public override string Name
        {
            get
            {
                return "RNSmartconnection";
            }
        }
    }
}
