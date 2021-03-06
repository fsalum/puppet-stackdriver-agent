# puppet-stackdriver-agent

Installs stackdriver-agent.

## Requirements

- Puppet version 3.4 or greater with Hiera support
- Puppet Forge modules:

| OS Family      | Module |
| :------------- |:-------------: |
| ALL            | [puppetlabs/stdlib](https://forge.puppetlabs.com/puppetlabs/stdlib) |
| Debian         | [puppetlabs/apt](https://forge.puppetlabs.com/puppetlabs/apt) |
| Windows        | [puppetlabs/registry](https://forge.puppetlabs.com/puppetlabs/registry), [joshcooper/powershell](https://forge.puppetlabs.com/joshcooper/powershell) |

Supported/tested Operating Systems by OS Family:

* Debian
    * Ubuntu
* RedHat
    * Amazon
    * CentOS
    * Fedora
* Windows
    * Server 2008
    * Server 2012

## Usage

This module requires a Stackdriver account.  Free trial accounts are available at their [website](http://www.stackdriver.com/signup).

### Base Agent

The stackdriver class includes the client:

```puppet
include stackdriver
```

You must specify your Stackdriver API key:

* Using Hiera (recommended)

```yaml
stackdriver::apikey: 'OMGBECKYLOOKATHERBUTTITSJUSTSOBIG'
```

* Using Puppet Code

```puppet
class { 'stackdriver':
    apikey => 'OMGBECKYLOOKATHERBUTTITSJUSTSOBIG',
}
```

## Plugins

### Usage
---

Two methods are supported for enabling plugins.

#### Using Hiera (recommended)

##### Configuration

Plugin settings may be configured via Hiera using the following format:
```yaml
stackdriver::plugin::<plugin name>::<param>:<value>
```

##### Usage
- Using an External Node Classifier

    Load the `stackdriver::plugin::<plugin name>` class

- Using Hiera

    Plugins may optionally be loaded using hiera itself. NOTE: an array merge is used to collect the plugin list.

    ```yaml
    stackdriver::plugins:
        - 'plugin name'
        - 'plugin name'
    ```

- Using Puppet Code

    Plugins may be enabled via puppet code while keeping the plugin settings in Hiera.

    ```puppet
    stackdriver::plugin { 'plugin name': }
    ```

#### Using Puppet Code

##### Configuration

Plugin settings may be specified during class load.

##### Usage
- Using an External Node Classifier

    Load the `stackdriver::plugin::<plugin name>` class and specify the class parameters.

- Using Puppet Code

    ```puppet
    class { 'stackdriver::plugin::<plugin name>':
        param1 => 'value',
        param2 => 'value',
    }
    ```


### Configuration
---

Plugin defaults are shown using the recommended Hiera format.
Values enclosed in <> do not have defaults and are required.
Values enclosed in () have an undef default and are optional.

### Redis

Configures the redis plugin on the local host running on port 6379.  Note: this module requires hiredis-devel be available to the system.

```yaml
stackdriver::plugin::redis::host:       'localhost'
stackdriver::plugin::redis::port:       '6379'
stackdriver::plugin::redis::timeout:    '2000'
```


### MongoDB

Configures the MongoDB plugin on the local host running on port 27017.

```yaml
stackdriver::plugin::mongo::host:       'localhost'
stackdriver::plugin::mongo::user:       'stackdriver'
stackdriver::plugin::mongo::password:   'ahzae8aiLiKoe'
stackdriver::plugin::mongo::port:       '27017'
```

### Postgresql

Configures the Postgreqsql plugin on the local host using UNIX domain sockets.  Prerequisites for this plugin are documented on Stackdriver's [support site](http://feedback.stackdriver.com/knowledgebase/articles/232555-postgresql-plugin).

```yaml
stackdriver::plugin::postgres::user:        'stackdriver'
stackdriver::plugin::postgres::password:    'xoiboov9Pai5e'
stackdriver::plugin::postgres::dbname:      '<REQUIRED PARAM>'
```

### nginx

Configures the nginx plugin on the local host running on port 80.

```yaml
stackdriver::plugin::nginx::user:       'stackdriver'
stackdriver::plugin::nginx::password:   'Eef3haeziqu3j'
stackdriver::plugin::nginx::url:        'http://127.0.0.1/nginx_status'
```

### apache

Configures the apache plugin on the local host running on port 80.
User and Password settings are only required if the URL requires authentication.

```yaml
stackdriver::plugin::apache::user:      '(OPTIONAL USER)'
stackdriver::plugin::apache::password:  '(OPTIONAL USER PASSWORD)'
stackdriver::plugin::apache::url:       'http://127.0.0.1/mod_status?auto'
```


### Elasticsearch

Configures the Elasticsearch plugin on the local host using port 9200.  Prerequisites for this plugin are documented on Stackdriver's [support site](http://feedback.stackdriver.com/knowledgebase/articles/268555-elasticsearch-plugin).


### RabbitMQ

Configures the RabbitMQ plugin on the local host running on port 5672.
All settings are required.

```yaml
stackdriver::plugin::rabbitmq::vhost:     '%2F'
stackdriver::plugin::rabbitmq::port:      '15672'
stackdriver::plugin::rabbitmq::queue:     '(Queue Name)'
stackdriver::plugin::rabbitmq::user:      'guest'
stackdriver::plugin::rabbitmq::password:  'guest'
```


## See Also

* Stackdriver Website: [http://www.stackdriver.com](http://www.stackdriver.com)
* Stackdriver Signup:  [http://www.stackdriver.com/signup](http://www.stackdriver.com/signup)


