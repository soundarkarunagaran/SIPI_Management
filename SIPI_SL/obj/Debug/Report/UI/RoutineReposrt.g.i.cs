﻿#pragma checksum "..\..\..\..\Report\UI\RoutineReposrt.xaml" "{406ea660-64cf-4c82-b6f0-42d48172a799}" "C0F1E722FFA12B7B651C7142DD557D13"
//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.34003
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

using Microsoft.Windows.Controls;
using Microsoft.Windows.Controls.PropertyGrid;
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


namespace SIPI_SL.Report.UI.Routine {
    
    
    /// <summary>
    /// RoutineReposrt
    /// </summary>
    public partial class RoutineReposrt : System.Windows.Window, System.Windows.Markup.IComponentConnector {
        
        
        #line 10 "..\..\..\..\Report\UI\RoutineReposrt.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal Microsoft.Windows.Controls.WatermarkTextBox yearTextBox;
        
        #line default
        #line hidden
        
        
        #line 12 "..\..\..\..\Report\UI\RoutineReposrt.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.Button previewReportButton;
        
        #line default
        #line hidden
        
        
        #line 13 "..\..\..\..\Report\UI\RoutineReposrt.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.Button searchButton;
        
        #line default
        #line hidden
        
        
        #line 25 "..\..\..\..\Report\UI\RoutineReposrt.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.ComboBox departmentCombobox;
        
        #line default
        #line hidden
        
        
        #line 44 "..\..\..\..\Report\UI\RoutineReposrt.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.ComboBox semesterCombobox;
        
        #line default
        #line hidden
        
        
        #line 59 "..\..\..\..\Report\UI\RoutineReposrt.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.ListView allRoutineListView;
        
        #line default
        #line hidden
        
        
        #line 75 "..\..\..\..\Report\UI\RoutineReposrt.xaml"
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1823:AvoidUnusedPrivateFields")]
        internal System.Windows.Controls.Button previewReportButton_department;
        
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
            System.Uri resourceLocater = new System.Uri("/SIPI_SL;component/report/ui/routinereposrt.xaml", System.UriKind.Relative);
            
            #line 1 "..\..\..\..\Report\UI\RoutineReposrt.xaml"
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
            this.yearTextBox = ((Microsoft.Windows.Controls.WatermarkTextBox)(target));
            return;
            case 2:
            this.previewReportButton = ((System.Windows.Controls.Button)(target));
            
            #line 12 "..\..\..\..\Report\UI\RoutineReposrt.xaml"
            this.previewReportButton.Click += new System.Windows.RoutedEventHandler(this.previewReportButton_Click);
            
            #line default
            #line hidden
            return;
            case 3:
            this.searchButton = ((System.Windows.Controls.Button)(target));
            
            #line 13 "..\..\..\..\Report\UI\RoutineReposrt.xaml"
            this.searchButton.Click += new System.Windows.RoutedEventHandler(this.searchButton_Click);
            
            #line default
            #line hidden
            return;
            case 4:
            this.departmentCombobox = ((System.Windows.Controls.ComboBox)(target));
            return;
            case 5:
            this.semesterCombobox = ((System.Windows.Controls.ComboBox)(target));
            return;
            case 6:
            this.allRoutineListView = ((System.Windows.Controls.ListView)(target));
            return;
            case 7:
            this.previewReportButton_department = ((System.Windows.Controls.Button)(target));
            
            #line 75 "..\..\..\..\Report\UI\RoutineReposrt.xaml"
            this.previewReportButton_department.Click += new System.Windows.RoutedEventHandler(this.Report_department_Button_Click);
            
            #line default
            #line hidden
            return;
            }
            this._contentLoaded = true;
        }
    }
}

