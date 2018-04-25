<body topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0">

    <script type="text/javascript" src="js/post_search.js"></script>
    <script type="text/javascript" src="https://www.google.com/jsapi"></script>

    <div align="left" id='language'>
        <script type="text/javascript"> google.load("elements", "1", {packages: "transliteration"}); function onLoad() {
                var options = {sourceLanguage: 'en', destinationLanguage: ['bn'], shortcutKey: 'ctrl+g', transliterationEnabled: true};
                var control = new google.elements.transliteration.TransliterationControl(options);
                var ids = ["transl1", "output"];
                control.makeTransliteratable(ids);
                control.showControl('translControl');
            }
            google.setOnLoadCallback(onLoad);</script>
    </div>

    <style>
        .text{
            font-family:solaimanLipi,arial;
            font-size:36px;
            line-height:22px;
        }
        #contactus input[type="text"],textarea
        {
            color : #000;
            border : 1px solid #990000;
            font-size:36px;
            background-color : #FBFBCA;
        }

        #contactus input:focus,textarea:focus
        {
            color : #000;
            border : 1px solid #990000;
            font-size:36px;
            background-color : #FEF7F8;
            -webkit-box-shadow:  0 0 7px #990000;
            -moz-box-shadow:  0 0 5px #990000;
            box-shadow:  0 0 5px #990000;
        }
    </style>

    <div align="center" style="display: none;">
        <div id='translControl' class="text" style="font-size: 14px; font-family: SolaimanLipi;">
        
        </div>
        <input type='textbox' id="transl1" class="text" style="font-size: 36px; font-family: SolaimanLipi;" />
    </div>
    <form target="_blank" id="ff" name="text" action="https://facebook.com/" method="get">
        <textarea name="status" id="output" class="text" style="margin : 5px 1px 0 0; color:black; width: 774px; height: 100px; font-size:24px; padding:6px;  font-family: SolaimanLipi; background-color:lightgreen;"></textarea>

        <input type="submit" value="Submit">
    </form>