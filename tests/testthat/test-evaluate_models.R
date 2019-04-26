context("evaluate_models")

cds <- load_a549()

test_that("evaluate_models() returns correct output for poisson models",{
  test_cds = cds[rowData(cds)$gene_short_name == "ANGPTL4",]
  fit_m = fit_models(test_cds, model_formula_str = "~log_dose", expression_family = "poisson")
  evaluated_fit = evaluate_fits(fit_m)
  expect_equal(evaluated_fit$null_deviance, 1182, tolerance=1e-3)
  expect_equal(evaluated_fit$df_null, 499)
  expect_equal(evaluated_fit$logLik, -875, tolerance=1e-3)
  expect_equal(evaluated_fit$AIC, 1754, tolerance=1e-3)
  expect_equal(evaluated_fit$BIC, NA_real_)
  expect_equal(evaluated_fit$deviance, 1134, tolerance=1e-3)
  expect_equal(evaluated_fit$df_residual, 498)
})

test_that("evaluate_models() returns correct output for quasipoisson models",{
  test_cds = cds[rowData(cds)$gene_short_name == "ANGPTL4",]
  fit_m = fit_models(test_cds, model_formula_str = "~log_dose", expression_family = "quasipoisson")
  evaluated_fit = evaluate_fits(fit_m)
  expect_equal(evaluated_fit$null_deviance, 1182, tolerance=1e-3)
  expect_equal(evaluated_fit$df_null, 499)
  expect_equal(evaluated_fit$logLik, NA)
  expect_equal(evaluated_fit$AIC, NA_real_)
  expect_equal(evaluated_fit$BIC, NA_real_)
  expect_equal(evaluated_fit$deviance, 1134, tolerance=1e-3)
  expect_equal(evaluated_fit$df_residual, 498)
})

### FIXME: Need cases for binomial (binary) data

test_that("evaluate_models() returns correct output for negative binomial models",{
  test_cds = cds[rowData(cds)$gene_short_name == "ANGPTL4",]
  fit = fit_models(test_cds, model_formula_str = "~log_dose", expression_family = "negbinomial")
  evaluated_fit = evaluate_fits(fit)
  expect_equal(evaluated_fit$null_deviance, 486, tolerance=1e-3)
  expect_equal(evaluated_fit$df_null, 499)
  expect_equal(evaluated_fit$logLik, -735., tolerance=1e-3)
  expect_equal(evaluated_fit$AIC, 1477, tolerance=1e-3)
  expect_equal(evaluated_fit$BIC, 1477, tolerance=1e-3)
  expect_equal(evaluated_fit$deviance, 468, tolerance=1e-3)
  expect_equal(evaluated_fit$df_residual, 498)
})

test_that("evaluate_models() returns correct output for zero-inflated poisson models",{
  test_cds = cds[rowData(cds)$gene_short_name == "ANGPTL4",]
  fit = fit_models(test_cds, model_formula_str = "~log_dose", expression_family = "zipoisson")
  evaluated_fit = evaluate_fits(fit)
  expect_equal(evaluated_fit$null_deviance, NA_real_)
  expect_equal(evaluated_fit$df_null, 498)
  expect_equal(evaluated_fit$logLik, -759, tolerance=1e-3)
  expect_equal(evaluated_fit$AIC, 1525, tolerance=1e-3)
  expect_equal(evaluated_fit$BIC, 1525, tolerance=1e-3)
  expect_equal(evaluated_fit$deviance, NA_real_)
  expect_equal(evaluated_fit$df_residual, 496)
})


test_that("evaluate_models() returns correct output for zero-inflated negative binomial models",{
  test_cds = cds[rowData(cds)$gene_short_name == "ANGPTL4",]
  fit = fit_models(test_cds, model_formula_str = "~log_dose", expression_family = "zinegbinomial")
  evaluated_fit = evaluate_fits(fit)
  expect_equal(evaluated_fit$null_deviance, NA_real_)
  expect_equal(evaluated_fit$df_null, 498)
  expect_equal(evaluated_fit$logLik, -731, tolerance=1e-3)
  expect_equal(evaluated_fit$AIC, 1473, tolerance=1e-3)
  expect_equal(evaluated_fit$BIC, 1473, tolerance=1e-3)
  expect_equal(evaluated_fit$deviance, NA_real_)
  expect_equal(evaluated_fit$df_residual, 495)
})