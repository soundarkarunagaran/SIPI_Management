﻿#pragma checksum "..\..\..\..\UI\Fees\FeesDetails.xaml" "{406ea660-64cf-4c82-b6f0-42d48172a799}" "65E0104DF54655834FA19A279594DB8E"
//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.34003
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

using RootLibrary.WPF.Localization;
using System;
using System.Diagnostics;
using System.Windows;
using System.Windows.Automation;
using System.Windows.Controls;
using System.Windows.Controls.Primitives;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Ink;
using System.Windows.Input;
using System.Windows.Markup;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Media.Effects;
using System.Windows.Media.Imaging;
using System.Windows.Media.Media3D;
using System.Windows.Media.TextFormatting;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Windows.Shell;


namespace SIPI_SL.UI.Fees {
    
    
    /// <summary>
    /// FeesDetails
    /// </summary>
    public partial class FeesDetails : System.Windows.Window, System.Windows.Markup.IComponentConnector {
        
        
        #line 8 "..\..\..\..\UI\Fees\FeesDetails.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.TextBox feesNameTextBox;
        
        #line default
        #line hidden
        
        
        #line 15 "..\..\..\..\UI\Fees\FeesDetails.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.ListView ClassPeriodListView;
        
        #line default
        #line hidden
        
        
        #line 17 "..\..\..\..\UI\Fees\FeesDetails.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.ContextMenu lstClassPeriod;
        
        #line default
        #line hidden
        
        
        #line 37 "..\..\..\..\UI\Fees\FeesDetails.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.Button addButton;
        
        #line default
        #line hidden
        
        private bool _contentLoaded;
        
        /// <summary>
        /// InitializeComponent
        /// </summary>
        [System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [System.CodeDom.Compiler.GeneratedCodeAttribute("PresentationBuildTasks", "4.0.0.0")]
        public void InitializeComponent() {
            if (_contentLoaded) {
                return;
            }
            _contentLoaded = true;
            System.Uri resourceLocater = new System.Uri("/SIPI_SL;component/ui/fees/feesdetails.xaml", System.UriKind.Relative);
            
            #line 1 "..\..\..\..\UI\Fees\FeesDetails.xaml"
            System.Windows.Application.LoadComponent(this, resourceLocater);
            
            #line default
            #line hidden
        }
        
        [System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [System.CodeDom.Compiler.GeneratedCodeAttribute("PresentationBuildTasks", "4.0.0.0")]
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Never)]
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Design", "CA1033:InterfaceMethodsShouldBeCallableByChildTypes")]
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Maintainability", "CA1502:AvoidExcessiveComplexity")]
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1800:DoNotCastUnnecessarily")]
        void System.Windows.Markup.IComponentConnector.Connect(int connectionId, object target) {
            switch (connectionId)
            {
            case 1:
            this.feesNameTextBox = ((System.Windows.Controls.TextBox)(target));
            return;
            case 2:
            this.ClassPeriodListView = ((System.Windows.Controls.ListView)(target));
            return;
            case 3:
            this.lstClassPeriod = ((System.Windows.Controls.ContextMenu)(target));
            return;
            case 4:
            this.addButton = ((System.Windows.Controls.Button)(target));
            
            #line 38 "..\..\..\..\UI\Fees\FeesDetails.xaml"
            this.addButton.Click += new System.Windows.RoutedEventHandler(this.addButton_Click);
            
            #line default
            #line hidden
            return;
            }
            this._contentLoaded = true;
        }
    }
}

