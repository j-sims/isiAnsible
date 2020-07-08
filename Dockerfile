FROM centos:centos7
RUN yum -y install epel-release && yum -y update && yum install -y ansible git python2-pip

RUN pip install isi-sdk-8-1-1

RUN git clone https://github.com/dell/ansible-isilon.git
WORKDIR /ansible-isilon/dellemc_ansible
ADD playbook.yml .
RUN mkdir -p /usr/lib/python2.7/site-packages/ansible/module_utils/storage/dell
RUN cp utils/* /usr/lib/python2.7/site-packages/ansible/module_utils/storage/dell 
RUN mkdir -p /usr/lib/python2.7/site-packages/ansible/modules/storage/dell
RUN cp isilon/library/* /usr/lib/python2.7/site-packages/ansible/modules/storage/dell
RUN cp doc_fragments/dellemc_isilon.py /usr/lib/python2.7/site-packages/ansible/plugins/doc_fragments/

CMD ["ansible-playbook", "playbook.yml"]
