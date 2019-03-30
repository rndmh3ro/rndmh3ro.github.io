#/bin/bash
set -x

for CALLBACK in $(ansible-doc -t callback -l | cut -d ' ' -f 1); do
  export ANSIBLE_STDOUT_CALLBACK=${CALLBACK}
  export ANSIBLE_STDOUT_CALLBACK=${CALLBACK}
	asciinema rec --overwrite --quiet /tmp/output/casts/${CALLBACK}.cast --command="ansible-playbook -i /root/hosts /root/playbook.yml -v --diff"
done

echo -n '
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="css/fontawesome-all.min.css" type="text/css">
  <link rel="stylesheet" href="css/asciinema-player.css" type="text/css">
  <link rel="stylesheet" href="css/wireframe.css">
  <link rel="stylesheet" href="css/prism.css">
  <title>
    Ansible Callback-Plugins
  </title>
</head>

<body>
  <div class="py-3">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <h1 class="display-4">Ansible Callback-Plugins</h1>
        </div>
      </div>
    </div>
  </div>
  <div class="py-5">
    <div class="container">
      <div class="row">
        <div class="col-md-10">
          <div class="col-md-12">
            <div class="col-md-12">
              <p class="lead">
                <a href="https://docs.ansible.com/ansible/devel/plugins/callback.html">Ansibles Callback plugins <i
                    class="fas fa-external-link-alt"></i></a> control most of the output you see when running the
                command line programs, but can also be used to add additional output, integrate with other tools and
                marshall the
                events to a storage backend.<br><br>Last updated for Ansible version: 2.7.9</p>' > /tmp/output/index.html

cd /tmp/output/casts
for i in *; do echo -n "
              <div class=\"card\">
                <div class=\"card-body\">
									<p><h2><a name=\"${i%.cast}-callback\" href=\"https://docs.ansible.com/ansible/devel/plugins/callback/${i%.cast}.html\">${i%.cast}<i class=\"fas fa-external-link-alt\"></i></a></h2></p>
                  <p>Description: $(ansible-doc -t callback -l | grep ${i%.cast} | cut -d " " -f 2- | sed 's/^\s*//g') </p>
                  <ul class=\"nav nav-tabs\">
                    <li class=\"nav-item\">
                      <a href=\"\" class=\"active nav-link\" data-toggle=\"tab\" data-target=\"#tabone-${i%.cast}\">Asciicast</a>
                    </li>
                    <li class=\"nav-item\">
                      <a class=\"nav-link\" href=\"\" data-toggle=\"tab\" data-target=\"#tabtwo-${i%.cast}\">Plaintext</a>
                    </li>
                  </ul>
                  <div class=\"tab-content mt-2\">
                    <div class=\"tab-pane fade show active\" id=\"tabone-${i%.cast}\" role=\"tabpanel\">
                      <asciinema-player id=\"player\" src=\"casts/$i\" title=\"actionable\" theme=\"monokai\" poster=\"data:text/plain,Ansible output with the ${i%.cast} callback module\"></asciinema-player>
                    </div>
                    <div class=\"tab-pane fade\" id=\"tabtwo-${i%.cast}\" role=\"tabpanel\">
                      <pre class=\"pre-scrollable\"><code class=\"language-yaml\">$(asciinema cat ${i} | ../ansi2html.sh --body-only)</code></pre>
                    </div>
                  </div>
                </div>
              </div>
"; done >> /tmp/output/index.html

echo -n '
              </p>
            </div>
          </div>
        </div>
        <div class="sticky-top col-md-2">
          <ul class="sticky-top list-unstyled">
            <li>
              <h1>Callbacks</h1>
            </li>
' >> /tmp/output/index.html

for i in *; do echo "            <li>
              <a href=\"#${i%.cast}-callback\">${i%.cast}</a>
            </li>" ;done >> /tmp/output/index.html

echo -n '
          </ul>
        </div>
      </div>
    </div>
  </div>
  <div class="bg-dark text-white p-1">
    <div class="container">
      <div class="row">
        <div class="col-md-12 mt-3 text-center">
          <p>Contact: github &lt;at&gt; gumpri &lt;dot&gt; ch <i class="far fa-envelope"></i></p>
        </div>
      </div>
    </div>
  </div>
  <script src="js/jquery-3.2.1.slim.min.js"></script>
  <script src="js/popper.min.js"></script>
  <script src="js/bootstrap.min.js"></script>
  <script src="js/asciinema-player.js"></script>
  <script src="js/prism.js"></script>
</body>

</html>
' >> /tmp/output/index.html
