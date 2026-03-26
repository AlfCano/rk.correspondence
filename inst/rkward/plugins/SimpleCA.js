// this code was generated using the rkwarddev package.
// perhaps don't make changes here, but in the rkwarddev script instead!

function preview(){
	
    function getColName(fullPath) {
        if (!fullPath) return '';
        if (fullPath.indexOf('$') > -1) {
            return fullPath.split('$')[1];
        } else if (fullPath.indexOf('[[') > -1) {
            var inner = fullPath.split('[[')[1].replace(']]', '');
            return inner.split('"').join('').split(String.fromCharCode(39)).join('');
        }
        return fullPath;
    }
  
    var data = getValue('ca_data');
    var ncp = getValue('ca_ncp');
    var dim_x = getValue('ca_dim_x');
    var dim_y = getValue('ca_dim_y');
    var f_type = getValue('ca_filter_type');
    var f_val = getValue('ca_filter_val');
    var repel = getValue('ca_repel') == 'TRUE' ? 'TRUE' : 'FALSE';
    var col_row = getValue('ca_col_row');
    var col_col = getValue('ca_col_col');
    var save_name = getValue('ca_save');

    var filter_str = 'NULL';
    if (f_type !== 'none') {
        filter_str = 'list(' + f_type + ' = ' + f_val + ')';
    }
  
    echo('require(FactoMineR)\nrequire(factoextra)\n');
    echo('preview_ca <- FactoMineR::CA(' + data + ', ncp = ' + ncp + ', graph = FALSE)\n');
    echo('print(factoextra::fviz_ca_biplot(preview_ca, axes = c(' + dim_x + ', ' + dim_y + '), select.row = ' + filter_str + ', select.col = ' + filter_str + ', repel = ' + repel + ', col.row = "' + col_row + '", col.col = "' + col_col + '", title = "CA Biplot"))\n');
  
}

function preprocess(is_preview){
	// add requirements etc. here
	if(is_preview) {
		echo("if(!base::require(FactoMineR)){stop(" + i18n("Preview not available, because package FactoMineR is not installed or cannot be loaded.") + ")}\n");
	} else {
		echo("require(FactoMineR)\n");
	}	if(is_preview) {
		echo("if(!base::require(factoextra)){stop(" + i18n("Preview not available, because package factoextra is not installed or cannot be loaded.") + ")}\n");
	} else {
		echo("require(factoextra)\n");
	}
}

function calculate(is_preview){
	// read in variables from dialog


	// the R code to be evaluated

    function getColName(fullPath) {
        if (!fullPath) return '';
        if (fullPath.indexOf('$') > -1) {
            return fullPath.split('$')[1];
        } else if (fullPath.indexOf('[[') > -1) {
            var inner = fullPath.split('[[')[1].replace(']]', '');
            return inner.split('"').join('').split(String.fromCharCode(39)).join('');
        }
        return fullPath;
    }
  
    var data = getValue('ca_data');
    var ncp = getValue('ca_ncp');
    var dim_x = getValue('ca_dim_x');
    var dim_y = getValue('ca_dim_y');
    var f_type = getValue('ca_filter_type');
    var f_val = getValue('ca_filter_val');
    var repel = getValue('ca_repel') == 'TRUE' ? 'TRUE' : 'FALSE';
    var col_row = getValue('ca_col_row');
    var col_col = getValue('ca_col_col');
    var save_name = getValue('ca_save');

    var filter_str = 'NULL';
    if (f_type !== 'none') {
        filter_str = 'list(' + f_type + ' = ' + f_val + ')';
    }
  
    echo('resultado_ca <- FactoMineR::CA(' + data + ', ncp = ' + ncp + ', graph = FALSE)\n');
  
}

function printout(is_preview){
	// read in variables from dialog


	// printout the results
	if(!is_preview) {
		new Header(i18n("Simple CA results")).print();	
	}
    function getColName(fullPath) {
        if (!fullPath) return '';
        if (fullPath.indexOf('$') > -1) {
            return fullPath.split('$')[1];
        } else if (fullPath.indexOf('[[') > -1) {
            var inner = fullPath.split('[[')[1].replace(']]', '');
            return inner.split('"').join('').split(String.fromCharCode(39)).join('');
        }
        return fullPath;
    }
  
    var data = getValue('ca_data');
    var ncp = getValue('ca_ncp');
    var dim_x = getValue('ca_dim_x');
    var dim_y = getValue('ca_dim_y');
    var f_type = getValue('ca_filter_type');
    var f_val = getValue('ca_filter_val');
    var repel = getValue('ca_repel') == 'TRUE' ? 'TRUE' : 'FALSE';
    var col_row = getValue('ca_col_row');
    var col_col = getValue('ca_col_col');
    var save_name = getValue('ca_save');

    var filter_str = 'NULL';
    if (f_type !== 'none') {
        filter_str = 'list(' + f_type + ' = ' + f_val + ')';
    }
  
    echo('rk.header("Simple Correspondence Analysis (CA)", level=2)\n');
    echo('rk.print(summary(resultado_ca, nb.dec = 3, nbelements = 10))\n');

    echo('rk.graph.on()\n');
    echo('print(factoextra::fviz_ca_biplot(resultado_ca, axes = c(' + dim_x + ', ' + dim_y + '), select.row = ' + filter_str + ', select.col = ' + filter_str + ', repel = ' + repel + ', col.row = "' + col_row + '", col.col = "' + col_col + '", title = "CA Biplot"))\n');
    echo('rk.graph.off()\n');

    if (save_name !== '') {
        echo('rk.header("Saved object: ' + save_name + '", level=4)\n');
    }
  
	if(!is_preview) {
		//// save result object
		// read in saveobject variables
		var caSave = getValue("ca_save");
		var caSaveActive = getValue("ca_save.active");
		var caSaveParent = getValue("ca_save.parent");
		// assign object to chosen environment
		if(caSaveActive) {
			echo(".GlobalEnv$" + caSave + " <- resultado_ca\n");
		}	
	}

}

