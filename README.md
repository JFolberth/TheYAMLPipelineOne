# TheYAMLPipleineOne
This repository is a starting point of housing YAML templates for Azure DevOps (ADO) Pipelines. The format for these templates is generic enough that indivduals can take what they need to create their own versions of these templates.

# Guidelines
All templates, unless they are task or variable templates, will call other templates. There should not be any embedding of tasks within the job or stage levels. This is done to optimize reusablility while also maintaining a single point of maintenace, the task for any changes. If changes are required to the task they should be done in a non breaking fashion, if this is not possible then use best judgement on creating a new task.
