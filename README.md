# TheYAMLPipelineOne

This repository is a starting point of housing YAML templates for Azure DevOps (ADO) Pipelines. The format for these templates is generic enough that individuals can take what they need to create their own versions of these templates. This project has been started based on my interaction with folks within the community and hopefully can be leveraged as a learning tool for those looking how to best leverage YAML Templates within their organizations.

# Guidelines

All templates, unless they are task or variable templates, will call other templates. There should not be any embedding of tasks within the job or stage levels. This is done to optimize reusability while also maintaining a single point of maintenance, the task for any changes. If changes are required to the task they should be done in a non breaking fashion, if this is not possible then use best judgement on creating a new task.

# Getting Started with YAML

For getting started would recommend watching my presentation to the [Omaha Azure User Group](https://www.youtube.com/watch?v=ERhaHiJriHI). In it will walk you through the evolution of using one YAML file per pipeline, templates, in the same pipeline, and lastly scaling it to the structure in this repo.

# Naming

Every file will have a '_' followed by the type of template it is. This is to help easily identify what type of file is being called by the parent templates. '_env' means the job can be used across multiple environments. This helps indicate if this job can scale and help differentiate it from a build job/stage which may only execute once.

# Variables
Each Azure environment will have it's one explicit variables. In this case it's the service connection related to the specific environment. I have only included 'dev'; however, the thought is multiple environments could be laid out. The assumption is the environment name passed in will match the abbreviation on the file.

# Templates to Date

This list is comprehensive starting at the stage level and moving on down. The thought here is a template is fully encapsulated by it's stage. For example if deploying just Bicep Infrastructure a completed template would consist of a stage template decomposing to jobs and the tasks which accomplishes the deployment of a Bicep file. A Bicep and dotNet deployment would be a stage, most likely, calling the same job templates the Bicep deployment template does and then also include the necessary dotNet templates.

| Template Name | Description | Stage Template File |
| ------------- | ----------- | ------------------- |
| Retain ADO Pipelines | This template will apply a manual retention lease to a pipeline | [retain_pipeline_stage.yml](stages/retain_pipeline_stage.yml)
| Build Bicep File | Will publish the bicep infrastructure folders as pipeline artifact as well as run a `validate` and `what-if` command against designated environments | [bicep_build_stage.yml](stages/bicep_build_stage.yml)
| Terraform Build | Will install Terraform, init, plan in parallel  across environment and regions. Does require [Azure Pipelines Terraform Task](https://marketplace.visualstudio.com/items?itemName=JasonBJohnson.azure-pipelines-tasks-terraform&ssr=false#overview)  and the remote backend as configured in the [azure_terraform_dev_variables.yml](variables/azure_terraform_dev_variables.yml) By default Terraform files are expected to be in a folder called 'Infrastructure' and leverage a variable file like dev.eus.variables.tfvars. This is easily changed be changed as needed for an organization by updating the 'TerraformWorkingDirectory' in the variables file and/or the 'additionalParameters' in the stage  | [terraform_build_stage.yml](stages/terraform_build_stage.yml)
| Terraform Apply | Will install Terraform, init, plan, apply across environment and regions with a stage for each region/environment combination Does require [Azure Pipelines Terraform Task](https://marketplace.visualstudio.com/items?itemName=JasonBJohnson.azure-pipelines-tasks-terraform&ssr=false#overview) and the remote backend as configured in the [azure_terraform_dev_variables.yml](variables/azure_terraform_dev_variables.yml). By default Terraform files are expected to be in a folder called 'Infrastructure' and leverage a variable file like dev.eus.variables.tfvars. This is easily changed be changed as needed for an organization by updating the 'TerraformWorkingDirectory' in the variables file and/or the 'additionalParameters' in the stage. | [terraform_apply_stage.yml](stages/terraform_apply_stage.yml)
| Azure Load Testing | Will execute an Azure Load Test file from the pipeline artifact. This will require the Service Connection to have the Test Contributor Role in Azure. This template can be grabed at the stage, job, or task level. A complete walkthrough and accompanied video can be found on my blog [An Azure Load Testing CI/CD Template](https://blog.johnfolberth.com/an-azure-load-testing-ci-cd-template/)| [load_test_stage.yml](stage/load_test_stage.yml)

# Additional Resources
- [Series of Post on Microsoft's Health and Life Sciences Blogs covering YAML Pipelines](https://techcommunity.microsoft.com/t5/healthcare-and-life-sciences/bg-p/HealthcareAndLifeSciencesBlog/label-name/YAML%20Pipeline%20Series)
- [YAML Pipelines Topic on my Personal Blog](https://blog.johnfolberth.com/category/professional/azure-devops/yaml-pipelines/)
- [Pipeline Schema on MS Learn](https://learn.microsoft.com/en-us/azure/devops/pipelines/yaml-schema/?view=azure-pipelines)
-  [YouTube Video Walking through Pipeline Maturity](https://www.youtube.com/watch?v=ERhaHiJriHI)