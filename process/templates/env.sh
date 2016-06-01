{% if is_aws is defined %}
# convert ec2 tags to env.sh file
{{ app_home }}/ec2_tags_to_env.sh {{ app_home }}/{{ name }}_dynamic_env.sh

# read env.sh file
source {{ app_home }}/{{ name }}_dynamic_env.sh
{% endif %}

{% if environment_variables is defined %}
# application environment variables
{% for item in environment_variables|dictsort %}
export {{ item[0] }}="{{ item[1] }}"
{% endfor %}
{% endif %}

{% if environment_script is defined %}

# app-specific environment script
{{ environment_script }}
{% endif %}
