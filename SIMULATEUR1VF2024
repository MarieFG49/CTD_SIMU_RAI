classdef SIMULATEUR1VF2024 < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                     matlab.ui.Figure
        GenerateButton               matlab.ui.control.Button
        keMo1EditField               matlab.ui.control.NumericEditField
        keMonth1Label                matlab.ui.control.Label
        lbdangmLMoEditField          matlab.ui.control.NumericEditField
        lbdangmLMoEditFieldLabel     matlab.ui.control.Label
        PatientConfigurationPanel    matlab.ui.container.Panel
        roGBqMo1EditField            matlab.ui.control.NumericEditField
        roGBqMo1Label                matlab.ui.control.Label
        N0cellsEditField             matlab.ui.control.NumericEditField
        N0cellsEditFieldLabel        matlab.ui.control.Label
        TdMoEditField                matlab.ui.control.NumericEditField
        TdMoEditFieldLabel           matlab.ui.control.Label
        aMo1EditField                matlab.ui.control.NumericEditField
        aMo1EditFieldLabel           matlab.ui.control.Label
        RespondingSwitch             matlab.ui.control.Switch
        RespondingSwitchLabel        matlab.ui.control.Label
        Tg0ngmLEditField             matlab.ui.control.NumericEditField
        Tg0ngmLEditFieldLabel        matlab.ui.control.Label
        TreatmentConfigurationPanel  matlab.ui.container.Panel
        DelayMonthSpinner            matlab.ui.control.Spinner
        DelayMonthSpinnerLabel       matlab.ui.control.Label
        NberFractionsSpinner         matlab.ui.control.Spinner
        NberFractionsSpinnerLabel    matlab.ui.control.Label
        ActivityGBqSpinner           matlab.ui.control.Spinner
        ActivityGBqSpinnerLabel      matlab.ui.control.Label
        RAItherapyResponseSimulatorLabel  matlab.ui.control.Label
    end

    
    properties (Access = private)
    end
    
    methods (Access = private)
    end
    


    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: GenerateButton
        function GenerateButtonPushed(app, event)

   
           a    =         app.aMo1EditField.Value;
           N0   =         app.N0cellsEditField.Value;
           r0   =         app.roGBqMo1EditField.Value;
           ke   =         app.keMo1EditField.Value;
           Tg0  =         app.Tg0ngmLEditField.Value;
           lbda =         app.lbdangmLMoEditField.Value;
           Td   =         app.TdMoEditField.Value;
           Act  =         app.ActivityGBqSpinner.Value; 
           Nbre =         app.NberFractionsSpinner.Value;
           Lag  =         app.DelayMonthSpinner.Value; 
           Color=         1;
  
           N00  =         N0; 
           Tg00 =         Tg0; 
           A00  =         0; 

       figure;
       
    for i=1:Nbre 
        syms Tg(t) N(t) A(t) Tg_2(t)

        ode1 = diff(A) == -a*log(2)*A; 
        cond1 = A(0) == Act+A00; 
        A(t) = dsolve(ode1,cond1); 

        ode2 = diff(N) == N*(log(2)/Td)-r0*A(t)*N;
        cond2 = N(0)==N00;
        N(t) = dsolve(ode2,cond2); 

        ode3 = diff(Tg) == lbda*N(t)-ke*Tg;
        cond3 = Tg(0)==Tg00;
        Tg(t) = dsolve(ode3,cond3); 
        Tg_2(t)=Tg(t-(i-1)*Lag);

        N00=subs(N,t,Lag); 
        N00=vpa(N00); 
        Tg00=subs(Tg,t,Lag); 
        Tg00=vpa(Tg00); 
        A00=subs(A,t,Lag);
        A00=vpa(A00); 

        colors=jet(10);
        
        fplot(Tg_2,[(i-1)*Lag (i)*Lag],'Color',colors(Color,:))
        hold on;
        clear Tg N A;
    end

        fplot(Tg_2,[(Nbre)*Lag 60],'Color',colors(Color,:))
        grid on
        xlabel('Time (Months)');
        ylabel('Tg(t) ng/mL');

        value = app.RespondingSwitch.Value;
        if strcmpi(value,'On') == 1
           	Statut = 'Responding';
        else Statut = 'Not Responding'
        end

        legend(['Nber = ' num2str(Nbre,4) 'Frac / Del = ' num2str(Lag,4) 'Mo / Act = ' num2str(Act,4) 'GBq / ' num2str(Statut)])
        end

        % Value changed function: RespondingSwitch
        function RespondingSwitchValueChanged(app, event)
            value = app.RespondingSwitch.Value;
            if strcmpi(value,'On') == 1
                 app.keMo1EditField.Value=0.319;
                 app.lbdangmLMoEditField.Value=3.86*10^-9;
                 app.TdMoEditField.Value=66.6;
                 app.roGBqMo1EditField.Value=0.00407;
                 app.aMo1EditField.Value=0.0169;
                 app.N0cellsEditField.Value=1.12*10^9;
            else
                 app.keMo1EditField.Value=0.319;
                 app.lbdangmLMoEditField.Value=3.86*10^-9;
                 app.TdMoEditField.Value=9.8;
                 app.roGBqMo1EditField.Value=0.00407;
                 app.aMo1EditField.Value=0.0169;
                 app.N0cellsEditField.Value=1.12*10^9;
            end
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Color = [0.8 0.8 0.8];
            app.UIFigure.Position = [100 100 560 335];
            app.UIFigure.Name = 'MATLAB App';

            % Create RAItherapyResponseSimulatorLabel
            app.RAItherapyResponseSimulatorLabel = uilabel(app.UIFigure);
            app.RAItherapyResponseSimulatorLabel.HorizontalAlignment = 'center';
            app.RAItherapyResponseSimulatorLabel.FontSize = 24;
            app.RAItherapyResponseSimulatorLabel.FontWeight = 'bold';
            app.RAItherapyResponseSimulatorLabel.Position = [40 285 503 32];
            app.RAItherapyResponseSimulatorLabel.Text = 'RAItherapy Response Simulator';

            % Create TreatmentConfigurationPanel
            app.TreatmentConfigurationPanel = uipanel(app.UIFigure);
            app.TreatmentConfigurationPanel.Title = 'Treatment Configuration';
            app.TreatmentConfigurationPanel.FontAngle = 'italic';
            app.TreatmentConfigurationPanel.FontSize = 14;
            app.TreatmentConfigurationPanel.Position = [30 109 220 166];

            % Create ActivityGBqSpinnerLabel
            app.ActivityGBqSpinnerLabel = uilabel(app.TreatmentConfigurationPanel);
            app.ActivityGBqSpinnerLabel.HorizontalAlignment = 'right';
            app.ActivityGBqSpinnerLabel.FontSize = 14;
            app.ActivityGBqSpinnerLabel.Position = [15 81 91 22];
            app.ActivityGBqSpinnerLabel.Text = 'Activity (GBq)';

            % Create ActivityGBqSpinner
            app.ActivityGBqSpinner = uispinner(app.TreatmentConfigurationPanel);
            app.ActivityGBqSpinner.Step = 1.85;
            app.ActivityGBqSpinner.Limits = [0 9.25];
            app.ActivityGBqSpinner.FontSize = 14;
            app.ActivityGBqSpinner.Position = [148 79 61 22];
            app.ActivityGBqSpinner.Value = 3.7;

            % Create NberFractionsSpinnerLabel
            app.NberFractionsSpinnerLabel = uilabel(app.TreatmentConfigurationPanel);
            app.NberFractionsSpinnerLabel.HorizontalAlignment = 'right';
            app.NberFractionsSpinnerLabel.FontSize = 14;
            app.NberFractionsSpinnerLabel.Position = [15 49 97 22];
            app.NberFractionsSpinnerLabel.Text = 'Nber Fractions';

            % Create NberFractionsSpinner
            app.NberFractionsSpinner = uispinner(app.TreatmentConfigurationPanel);
            app.NberFractionsSpinner.Limits = [0 10];
            app.NberFractionsSpinner.FontSize = 14;
            app.NberFractionsSpinner.Position = [149 47 60 22];
            app.NberFractionsSpinner.Value = 1;

            % Create DelayMonthSpinnerLabel
            app.DelayMonthSpinnerLabel = uilabel(app.TreatmentConfigurationPanel);
            app.DelayMonthSpinnerLabel.HorizontalAlignment = 'right';
            app.DelayMonthSpinnerLabel.FontSize = 14;
            app.DelayMonthSpinnerLabel.Position = [16 13 93 22];
            app.DelayMonthSpinnerLabel.Text = 'Delay (Month)';

            % Create DelayMonthSpinner
            app.DelayMonthSpinner = uispinner(app.TreatmentConfigurationPanel);
            app.DelayMonthSpinner.Limits = [0 12];
            app.DelayMonthSpinner.FontSize = 14;
            app.DelayMonthSpinner.Position = [149 14 60 22];
            app.DelayMonthSpinner.Value = 1;

            % Create Tg0ngmLEditFieldLabel
            app.Tg0ngmLEditFieldLabel = uilabel(app.UIFigure);
            app.Tg0ngmLEditFieldLabel.HorizontalAlignment = 'right';
            app.Tg0ngmLEditFieldLabel.FontSize = 14;
            app.Tg0ngmLEditFieldLabel.Position = [43 221 81 22];
            app.Tg0ngmLEditFieldLabel.Text = 'Tg0 (ng/mL)';

            % Create Tg0ngmLEditField
            app.Tg0ngmLEditField = uieditfield(app.UIFigure, 'numeric');
            app.Tg0ngmLEditField.FontSize = 14;
            app.Tg0ngmLEditField.Position = [178 223 61 22];
            app.Tg0ngmLEditField.Value = 100;

            % Create PatientConfigurationPanel
            app.PatientConfigurationPanel = uipanel(app.UIFigure);
            app.PatientConfigurationPanel.Title = 'Patient Configuration';
            app.PatientConfigurationPanel.FontAngle = 'italic';
            app.PatientConfigurationPanel.FontSize = 14;
            app.PatientConfigurationPanel.Position = [297 13 246 262];

            % Create RespondingSwitchLabel
            app.RespondingSwitchLabel = uilabel(app.PatientConfigurationPanel);
            app.RespondingSwitchLabel.HorizontalAlignment = 'center';
            app.RespondingSwitchLabel.FontSize = 14;
            app.RespondingSwitchLabel.Position = [22 176 80 22];
            app.RespondingSwitchLabel.Text = 'Responding';

            % Create RespondingSwitch
            app.RespondingSwitch = uiswitch(app.PatientConfigurationPanel, 'slider');
 app.RespondingSwitch.ValueChangedFcn = createCallbackFcn(app, @RespondingSwitchValueChanged, true);
            app.RespondingSwitch.FontSize = 14;
            app.RespondingSwitch.Position = [38 202 45 20];

            % Create aMo1EditFieldLabel
            app.aMo1EditFieldLabel = uilabel(app.PatientConfigurationPanel);
            app.aMo1EditFieldLabel.HorizontalAlignment = 'right';
            app.aMo1EditFieldLabel.FontSize = 14;
            app.aMo1EditFieldLabel.FontColor = [0.502 0.502 0.502];
            app.aMo1EditFieldLabel.Position = [59 81 64 22];
            app.aMo1EditFieldLabel.Text = 'a (Mo^-1)';

            % Create aMo1EditField
            app.aMo1EditField = uieditfield(app.PatientConfigurationPanel, 'numeric');
            app.aMo1EditField.FontSize = 14;
            app.aMo1EditField.FontColor = [0.502 0.502 0.502];
            app.aMo1EditField.Position = [138 81 100 22];
            app.aMo1EditField.Value = 0.0169;

            % Create TdMoEditFieldLabel
            app.TdMoEditFieldLabel = uilabel(app.PatientConfigurationPanel);
            app.TdMoEditFieldLabel.HorizontalAlignment = 'right';
            app.TdMoEditFieldLabel.FontSize = 14;
            app.TdMoEditFieldLabel.Position = [122 200 61 22];
            app.TdMoEditFieldLabel.Text = 'Td (Mo)';

            % Create TdMoEditField
            app.TdMoEditField = uieditfield(app.PatientConfigurationPanel, 'numeric');
            app.TdMoEditField.FontSize = 14;
            app.TdMoEditField.Position = [192 201 35 22];
            app.TdMoEditField.Value = 9.8;

            % Create N0cellsEditFieldLabel
            app.N0cellsEditFieldLabel = uilabel(app.PatientConfigurationPanel);
            app.N0cellsEditFieldLabel.HorizontalAlignment = 'right';
            app.N0cellsEditFieldLabel.FontSize = 14;
            app.N0cellsEditFieldLabel.FontColor = [0.502 0.502 0.502];
            app.N0cellsEditFieldLabel.Position = [55 46 64 22];
            app.N0cellsEditFieldLabel.Text = 'N0 (cells)';

            % Create N0cellsEditField
app.N0cellsEditField = uieditfield(app.PatientConfigurationPanel, 'numeric');
            app.N0cellsEditField.FontSize = 14;
            app.N0cellsEditField.FontColor = [0.502 0.502 0.502];
            app.N0cellsEditField.Position = [140 49 99 22];
            app.N0cellsEditField.Value = 1120000000;

            % Create roGBqMo1Label
            app.roGBqMo1Label = uilabel(app.PatientConfigurationPanel);
            app.roGBqMo1Label.HorizontalAlignment = 'right';
            app.roGBqMo1Label.FontSize = 14;
            app.roGBqMo1Label.FontColor = [0.502 0.502 0.502];
            app.roGBqMo1Label.Position = [22 16 101 22];
            app.roGBqMo1Label.Text = 'ro (GBq.Mo)^-1';

            % Create roGBqMo1EditField
            app.roGBqMo1EditField = uieditfield(app.PatientConfigurationPanel, 'numeric');
            app.roGBqMo1EditField.FontSize = 14;
            app.roGBqMo1EditField.FontColor = [0.502 0.502 0.502];
            app.roGBqMo1EditField.Position = [138 16 100 22];
            app.roGBqMo1EditField.Value = 0.00407;

            % Create lbdangmLMoEditFieldLabel
            app.lbdangmLMoEditFieldLabel = uilabel(app.UIFigure);
            app.lbdangmLMoEditFieldLabel.HorizontalAlignment = 'right';
            app.lbdangmLMoEditFieldLabel.FontSize = 14;
            app.lbdangmLMoEditFieldLabel.Position = [304 158 116 22];
            app.lbdangmLMoEditFieldLabel.Text = 'lbda (ng/(mL.Mo))';

            % Create lbdangmLMoEditField
            app.lbdangmLMoEditField = uieditfield(app.UIFigure, 'numeric');
            app.lbdangmLMoEditField.FontSize = 14;
            app.lbdangmLMoEditField.Position = [435 158 100 22];
            app.lbdangmLMoEditField.Value = 3.86e-09;

            % Create keMonth1Label
            app.keMonth1Label = uilabel(app.UIFigure);
            app.keMonth1Label.HorizontalAlignment = 'right';
            app.keMonth1Label.FontSize = 14;
            app.keMonth1Label.Position = [346 125 71 22];
            app.keMonth1Label.Text = 'ke (Mo^-1)';

            % Create keMo1EditField
            app.keMo1EditField = uieditfield(app.UIFigure, 'numeric');
            app.keMo1EditField.FontSize = 14;
            app.keMo1EditField.Position = [436 125 99 22];
            app.keMo1EditField.Value = 0.319;

            % Create GenerateButton
            app.GenerateButton = uibutton(app.UIFigure, 'push');
app.GenerateButton.ButtonPushedFcn = createCallbackFcn(app, @GenerateButtonPushed, true);
            app.GenerateButton.FontSize = 18;
            app.GenerateButton.Position = [79 29 127 51];
            app.GenerateButton.Text = 'Generate';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = SIMULATEUR1VF2024

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end

