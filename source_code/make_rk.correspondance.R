local({
  # =========================================================================================
  # 1. Definición del Paquete y Metadatos
  # =========================================================================================
  require(rkwarddev)
  rkwarddev.required("0.10-3")

  package_about <- rk.XML.about(
    name = "rk.correspondence",
    author = person(
      given = "Alfonso",
      family = "Cano Robles",
      email = "alfonso.cano@correo.buap.mx",
      role = c("aut", "cre")
    ),
    about = list(
      desc = "RKWard Plugin for Correspondence Analysis (CA & MCA) using FactoMineR and factoextra.",
      version = "0.0.1",
      url = "https://github.com/AlfCano/rk.correspondence",
      license = "GPL (>= 3)"
    )
  )

  common_hierarchy <- list("analysis", "Multivariate")

  # =========================================================================================
  # 2. Funciones JS Auxiliares
  # =========================================================================================
  js_parse_helper <- "
    function getColName(fullPath) {
        if (!fullPath) return '';
        if (fullPath.indexOf('$') > -1) {
            return fullPath.split('$')[1];
        } else if (fullPath.indexOf('[[') > -1) {
            var inner = fullPath.split('[[')[1].replace(']]', '');
            return inner.split('\"').join('').split(String.fromCharCode(39)).join('');
        }
        return fullPath;
    }
  "

  # =========================================================================================
  # Correspondence Analysis (CA)
  # =========================================================================================

  help_ca <- rk.rkh.doc(
    title = rk.rkh.title(text = "Simple Correspondence Analysis (CA)"),
    summary = rk.rkh.summary(text = "Advanced CA with dimensionality control and filtering (R Commander style).")
  )

  ca_selector <- rk.XML.varselector(id.name = "ca_selector")
  ca_data <- rk.XML.varslot("Contingency Table or Data Frame", source = "ca_selector", required = TRUE, id.name = "ca_data")

  ca_ncp <- rk.XML.spinbox("Number of dimensions to retain (ncp)", min = 2, initial = 5, id.name = "ca_ncp")
  ca_dim_x <- rk.XML.spinbox("X-axis Dimension", min = 1, initial = 1, id.name = "ca_dim_x")
  ca_dim_y <- rk.XML.spinbox("Y-axis Dimension", min = 2, initial = 2, id.name = "ca_dim_y")

  ca_filter_type <- rk.XML.dropdown("Filter points in plot by", options = list(
    "Show all points (None)" = list(val = "none", chk = TRUE),
    "Top Contributors (Number)" = list(val = "contrib"),
    "Quality of representation (cos2)" = list(val = "cos2")
  ), id.name = "ca_filter_type")
  ca_filter_val <- rk.XML.spinbox("Filter threshold (e.g. 5 for contrib, 0.5 for cos2)", min = 0, initial = 5, real = TRUE, id.name = "ca_filter_val")

  ca_repel <- rk.XML.cbox("Avoid text overlapping (repel)", value = "TRUE", chk = TRUE, id.name = "ca_repel")
  ca_col_row <- rk.XML.input("Row color", initial = "blue", id.name = "ca_col_row")
  ca_col_col <- rk.XML.input("Column color", initial = "red", id.name = "ca_col_col")

  ca_save <- rk.XML.saveobj("Save CA Result Object", chk = TRUE, initial = "resultado_ca", id.name = "ca_save")
  ca_preview <- rk.XML.preview(mode = "plot")

  tab_ca_data <- rk.XML.row(ca_selector, rk.XML.col(ca_data, rk.XML.frame(ca_ncp, label="Model Settings")))
  tab_ca_plot <- rk.XML.col(rk.XML.frame(ca_dim_x, ca_dim_y, label="Dimensions to plot"), rk.XML.frame(ca_filter_type, ca_filter_val, label="Filtering"), rk.XML.frame(ca_repel, ca_col_row, ca_col_col, label="Aesthetics"))
  tab_ca_out <- rk.XML.col(ca_save, ca_preview)

  dialog_ca <- rk.XML.dialog(label = "Simple Correspondence Analysis", child = rk.XML.tabbook(tabs = list("Data" = tab_ca_data, "Plot Options" = tab_ca_plot, "Output" = tab_ca_out)))

  js_body_ca <- "
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
  "

  js_calc_ca <- paste0(js_parse_helper, js_body_ca, "
    echo('resultado_ca <- FactoMineR::CA(' + data + ', ncp = ' + ncp + ', graph = FALSE)\\n');
  ")

  js_print_ca <- paste0(js_parse_helper, js_body_ca, "
    echo('rk.header(\"Simple Correspondence Analysis (CA)\", level=2)\\n');
    echo('rk.print(summary(resultado_ca, nb.dec = 3, nbelements = 10))\\n');

    echo('rk.graph.on()\\n');
    echo('print(factoextra::fviz_ca_biplot(resultado_ca, axes = c(' + dim_x + ', ' + dim_y + '), select.row = ' + filter_str + ', select.col = ' + filter_str + ', repel = ' + repel + ', col.row = \"' + col_row + '\", col.col = \"' + col_col + '\", title = \"CA Biplot\"))\\n');
    echo('rk.graph.off()\\n');

    if (save_name !== '') {
        echo('rk.header(\"Saved object: ' + save_name + '\", level=4)\\n');
    }
  ")

  js_preview_ca <- paste0(js_parse_helper, js_body_ca, "
    echo('require(FactoMineR)\\nrequire(factoextra)\\n');
    echo('preview_ca <- FactoMineR::CA(' + data + ', ncp = ' + ncp + ', graph = FALSE)\\n');
    echo('print(factoextra::fviz_ca_biplot(preview_ca, axes = c(' + dim_x + ', ' + dim_y + '), select.row = ' + filter_str + ', select.col = ' + filter_str + ', repel = ' + repel + ', col.row = \"' + col_row + '\", col.col = \"' + col_col + '\", title = \"CA Biplot\"))\\n');
  ")

  # =========================================================================================
  # Multiple Correspondence Analysis (MCA)
  # =========================================================================================

  help_mca <- rk.rkh.doc(
    title = rk.rkh.title(text = "Multiple Correspondence Analysis (MCA)"),
    summary = rk.rkh.summary(text = "Performs MCA on a dataset with multiple categorical variables.")
  )

  mca_selector <- rk.XML.varselector(id.name = "mca_selector")
  mca_data <- rk.XML.varslot("Dataset", source = "mca_selector", required = TRUE, id.name = "mca_data")
  mca_vars <- rk.XML.varslot("Active Categorical Variables", source = "mca_selector", multi = TRUE, required = TRUE, id.name = "mca_vars")

  mca_ncp <- rk.XML.spinbox("Dimensions to retain (ncp)", min = 2, initial = 5, id.name = "mca_ncp")
  mca_dim_x <- rk.XML.spinbox("X-axis Dim", min = 1, initial = 1, id.name = "mca_dim_x")
  mca_dim_y <- rk.XML.spinbox("Y-axis Dim", min = 2, initial = 2, id.name = "mca_dim_y")

  mca_plot_type <- rk.XML.dropdown("Plot Type", options = list(
    "Biplot (Variables & Individuals)" = list(val = "biplot", chk = TRUE),
    "Variables only" = list(val = "var"),
    "Individuals only" = list(val = "ind")
  ), id.name = "mca_plot_type")
  mca_repel <- rk.XML.cbox("Avoid text overlapping (repel)", value = "TRUE", chk = TRUE, id.name = "mca_repel")

  mca_save <- rk.XML.saveobj("Save MCA Result Object", chk = TRUE, initial = "resultado_mca", id.name = "mca_save")
  mca_preview <- rk.XML.preview(mode = "plot")

  tab_mca_data <- rk.XML.row(mca_selector, rk.XML.col(mca_data, mca_vars, rk.XML.frame(mca_ncp)))
  tab_mca_plot <- rk.XML.col(rk.XML.frame(mca_dim_x, mca_dim_y), mca_plot_type, mca_repel)
  tab_mca_out <- rk.XML.col(mca_save, mca_preview)

  dialog_mca <- rk.XML.dialog(label = "Multiple Correspondence Analysis", child = rk.XML.tabbook(tabs = list("Data & Variables" = tab_mca_data, "Plot Options" = tab_mca_plot, "Output" = tab_mca_out)))

  js_body_mca <- "
    var data = getValue('mca_data');
    var ncp = getValue('mca_ncp');
    var dim_x = getValue('mca_dim_x');
    var dim_y = getValue('mca_dim_y');
    var p_type = getValue('mca_plot_type');
    var repel = getValue('mca_repel') == 'TRUE' ? 'TRUE' : 'FALSE';
    var save_name = getValue('mca_save');

    var raw_vars = getValue('mca_vars').split('\\n');
    var clean_vars =[];
    for(var i=0; i < raw_vars.length; i++) {
        if(raw_vars[i] !== '') {
            var colName = getColName(raw_vars[i]);
            clean_vars.push('\"' + colName + '\"');
        }
    }
    var r_vector_vars = 'c(' + clean_vars.join(', ') + ')';
  "

  js_calc_mca <- paste0(js_parse_helper, js_body_mca, "
    echo('mca_subset <- as.data.frame(' + data + ')[, ' + r_vector_vars + ', drop=FALSE]\\n');
    echo('resultado_mca <- FactoMineR::MCA(mca_subset, ncp = ' + ncp + ', graph = FALSE)\\n');
  ")

  js_print_mca <- paste0(js_parse_helper, js_body_mca, "
    echo('rk.header(\"Multiple Correspondence Analysis (MCA)\", level=2)\\n');
    echo('rk.print(summary(resultado_mca, nb.dec = 3, nbelements = 10))\\n');

    echo('rk.graph.on()\\n');
    if(p_type === 'biplot') {
        echo('print(factoextra::fviz_mca_biplot(resultado_mca, axes = c(' + dim_x + ', ' + dim_y + '), repel = ' + repel + '))\\n');
    } else if (p_type === 'var') {
        echo('print(factoextra::fviz_mca_var(resultado_mca, axes = c(' + dim_x + ', ' + dim_y + '), repel = ' + repel + '))\\n');
    } else {
        echo('print(factoextra::fviz_mca_ind(resultado_mca, axes = c(' + dim_x + ', ' + dim_y + '), repel = ' + repel + '))\\n');
    }
    echo('rk.graph.off()\\n');

    if (save_name !== '') {
       echo('rk.header(\"Saved object: ' + save_name + '\", level=4)\\n');
    }
  ")

  js_preview_mca <- paste0(js_parse_helper, js_body_mca, "
    echo('require(FactoMineR)\\nrequire(factoextra)\\n');
    echo('prev_subset <- as.data.frame(' + data + ')[, ' + r_vector_vars + ', drop=FALSE]\\n');
    echo('preview_mca <- FactoMineR::MCA(prev_subset, ncp = ' + ncp + ', graph = FALSE)\\n');

    if(p_type === 'biplot') {
        echo('print(factoextra::fviz_mca_biplot(preview_mca, axes = c(' + dim_x + ', ' + dim_y + '), repel = ' + repel + '))\\n');
    } else if (p_type === 'var') {
        echo('print(factoextra::fviz_mca_var(preview_mca, axes = c(' + dim_x + ', ' + dim_y + '), repel = ' + repel + '))\\n');
    } else {
        echo('print(factoextra::fviz_mca_ind(preview_mca, axes = c(' + dim_x + ', ' + dim_y + '), repel = ' + repel + '))\\n');
    }
  ")

  # Declaración del componente adicional
  component_mca <- rk.plugin.component("Multiple CA", xml = list(dialog = dialog_mca), js = list(require = c("FactoMineR", "factoextra"), calculate = js_calc_mca, printout = js_print_mca, preview = js_preview_mca), hierarchy = common_hierarchy, rkh = list(help = help_mca))

  # =========================================================================================
  # 3. Llamada Final (Skeleton)
  # =========================================================================================

  rk.plugin.skeleton(
    about = package_about,
    path = ".",
    # COMPONENTE PRINCIPAL (CA Simple) mapeado directamente a la raíz:
    xml = list(dialog = dialog_ca),
    js = list(require = c("FactoMineR", "factoextra"), calculate = js_calc_ca, printout = js_print_ca, preview = js_preview_ca),
    rkh = list(help = help_ca),
    # COMPONENTES ADICIONALES (MCA):
    components = list(component_mca),
    # MAPEO: El nombre principal del pluginmap representa a la entrada raíz
    pluginmap = list(
        name = "Simple CA",
        hierarchy = common_hierarchy
    ),
    create = c("pmap", "xml", "js", "desc", "rkh"),
    load = TRUE,
    overwrite = TRUE,
    show = FALSE
  )

  cat("\nPlugin package 'rk.correspondence' generated successfully with CA and MCA.\n")
  cat("Menu locations:\n")
  cat("  1. Analysis -> Multivariate -> Simple CA\n")
  cat("  2. Analysis -> Multivariate -> Multiple CA\n")
})
