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
  
    var data = getValue('mca_data');
    var ncp = getValue('mca_ncp');
    var dim_x = getValue('mca_dim_x');
    var dim_y = getValue('mca_dim_y');
    var p_type = getValue('mca_plot_type');
    var repel = getValue('mca_repel') == 'TRUE' ? 'TRUE' : 'FALSE';
    var save_name = getValue('mca_save');

    var raw_vars = getValue('mca_vars').split('\n');
    var clean_vars =[];
    for(var i=0; i < raw_vars.length; i++) {
        if(raw_vars[i] !== '') {
            var colName = getColName(raw_vars[i]);
            clean_vars.push('"' + colName + '"');
        }
    }
    var r_vector_vars = 'c(' + clean_vars.join(', ') + ')';
  
    echo('require(FactoMineR)\nrequire(factoextra)\n');
    echo('prev_subset <- as.data.frame(' + data + ')[, ' + r_vector_vars + ', drop=FALSE]\n');
    echo('preview_mca <- FactoMineR::MCA(prev_subset, ncp = ' + ncp + ', graph = FALSE)\n');

    if(p_type === 'biplot') {
        echo('print(factoextra::fviz_mca_biplot(preview_mca, axes = c(' + dim_x + ', ' + dim_y + '), repel = ' + repel + '))\n');
    } else if (p_type === 'var') {
        echo('print(factoextra::fviz_mca_var(preview_mca, axes = c(' + dim_x + ', ' + dim_y + '), repel = ' + repel + '))\n');
    } else {
        echo('print(factoextra::fviz_mca_ind(preview_mca, axes = c(' + dim_x + ', ' + dim_y + '), repel = ' + repel + '))\n');
    }
  
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
  
    var data = getValue('mca_data');
    var ncp = getValue('mca_ncp');
    var dim_x = getValue('mca_dim_x');
    var dim_y = getValue('mca_dim_y');
    var p_type = getValue('mca_plot_type');
    var repel = getValue('mca_repel') == 'TRUE' ? 'TRUE' : 'FALSE';
    var save_name = getValue('mca_save');

    var raw_vars = getValue('mca_vars').split('\n');
    var clean_vars =[];
    for(var i=0; i < raw_vars.length; i++) {
        if(raw_vars[i] !== '') {
            var colName = getColName(raw_vars[i]);
            clean_vars.push('"' + colName + '"');
        }
    }
    var r_vector_vars = 'c(' + clean_vars.join(', ') + ')';
  
    echo('mca_subset <- as.data.frame(' + data + ')[, ' + r_vector_vars + ', drop=FALSE]\n');
    echo('resultado_mca <- FactoMineR::MCA(mca_subset, ncp = ' + ncp + ', graph = FALSE)\n');
  
}

function printout(is_preview){
	// read in variables from dialog


	// printout the results
	if(!is_preview) {
		new Header(i18n("Multiple CA results")).print();	
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
  
    var data = getValue('mca_data');
    var ncp = getValue('mca_ncp');
    var dim_x = getValue('mca_dim_x');
    var dim_y = getValue('mca_dim_y');
    var p_type = getValue('mca_plot_type');
    var repel = getValue('mca_repel') == 'TRUE' ? 'TRUE' : 'FALSE';
    var save_name = getValue('mca_save');

    var raw_vars = getValue('mca_vars').split('\n');
    var clean_vars =[];
    for(var i=0; i < raw_vars.length; i++) {
        if(raw_vars[i] !== '') {
            var colName = getColName(raw_vars[i]);
            clean_vars.push('"' + colName + '"');
        }
    }
    var r_vector_vars = 'c(' + clean_vars.join(', ') + ')';
  
    echo('rk.header("Multiple Correspondence Analysis (MCA)", level=2)\n');
    echo('rk.print(summary(resultado_mca, nb.dec = 3, nbelements = 10))\n');

    echo('rk.graph.on()\n');
    if(p_type === 'biplot') {
        echo('print(factoextra::fviz_mca_biplot(resultado_mca, axes = c(' + dim_x + ', ' + dim_y + '), repel = ' + repel + '))\n');
    } else if (p_type === 'var') {
        echo('print(factoextra::fviz_mca_var(resultado_mca, axes = c(' + dim_x + ', ' + dim_y + '), repel = ' + repel + '))\n');
    } else {
        echo('print(factoextra::fviz_mca_ind(resultado_mca, axes = c(' + dim_x + ', ' + dim_y + '), repel = ' + repel + '))\n');
    }
    echo('rk.graph.off()\n');

    if (save_name !== '') {
       echo('rk.header("Saved object: ' + save_name + '", level=4)\n');
    }
  
	if(!is_preview) {
		//// save result object
		// read in saveobject variables
		var mcaSave = getValue("mca_save");
		var mcaSaveActive = getValue("mca_save.active");
		var mcaSaveParent = getValue("mca_save.parent");
		// assign object to chosen environment
		if(mcaSaveActive) {
			echo(".GlobalEnv$" + mcaSave + " <- resultado_mca\n");
		}	
	}

}

