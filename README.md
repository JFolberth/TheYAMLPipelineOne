# TheYAMLPipleineOne

This repository is a starting point of housing YAML templates for Azure DevOps (ADO) Pipelines. The format for these templates is generic enough that indivduals can take what they need to create their own versions of these templates. This project has been started based on my interaction with folks within the community and hopefully can be leveraged as a learning tool for those looking how to best leverage YAML Templates within their organizations.

# Guidelines

All templates, unless they are task or variable templates, will call other templates. There should not be any embedding of tasks within the job or stage levels. This is done to optimize reusablility while also maintaining a single point of maintenace, the task for any changes. If changes are required to the task they should be done in a non breaking fashion, if this is not possible then use best judgement on creating a new task.

# Templates to Date

This list is comprehensive starting at the stage level and moving on down. The though here is a template is fully encapsulated by it's stage. For example if deploying just Bicep Infrastructure a completed template would consist of a stage template decomposing to jobs and the tasks which accomplishes the deployment of a Bicep file. A Bicep and dotNet deployment would be a stage, most likely, calling the same job tempaltes the Bicep deployment template does and then also include the necessary dotNet templates.

| Template Name | Description | Stage Template File |
| ------------- | ----------- | ------------------- |
| Retain ADO Pipelines | This template will apply a manual release to a pipeline | [retain_pipeline_stage.yml](stages/retain_pipeline_stage.yml)
