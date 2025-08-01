import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inputs e Interatividade',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const FormularioSimplesPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FormularioSimplesPage extends StatefulWidget {
  const FormularioSimplesPage({super.key});

  @override
  State<FormularioSimplesPage> createState() => _FormularioSimplesPageState();
}

class _FormularioSimplesPageState extends State<FormularioSimplesPage> {
  // Chave global para o Formulário - essencial para validação
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controladores para os campos de texto
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  // Variável para armazenar o texto de um GestureDetector
  String _toqueMensagem = 'Nenhum toque detectado ainda.';

  @override
  void dispose() {
    // É importante descartar os controllers para liberar recursos
    _nomeController.dispose();
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  void _enviarFormulario() {
    // Aciona a validação de todos os TextFormField dentro deste Form
    if (_formKey.currentState!.validate()) {
      // Se todos os campos forem válidos, processa os dados
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Formulário Válido!\nNome: ${_nomeController.text}, Email: ${_emailController.text}'),
          backgroundColor: Colors.green,
        ),
      );
      // Aqui você normalmente enviaria os dados para um backend
      print('Dados a enviar:');
      print('Nome: ${_nomeController.text}');
      print('Email: ${_emailController.text}');
      print('Senha: ${_senhaController.text}');
    } else {
      // Caso haja erros de validação
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, corrija os erros no formulário.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrada de Dados e Interatividade'),
      ),
      body: SingleChildScrollView( // Permite rolar a tela se o teclado aparecer
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey, // Associa a chave ao Form
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // Estica os elementos horizontalmente
            children: <Widget>[
              // Título da Seção
              const Text(
                'Cadastre-se',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),

              // Campo de Nome (TextField básico)
              TextField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome Completo',
                  hintText: 'Ex: João da Silva',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                onChanged: (text) {
                  // Pode ser usado para validação em tempo real ou outras ações
                  // print('Nome digitado: $text');
                },
              ),
              const SizedBox(height: 20),

              // Campo de Email (TextFormField com validação)
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress, // Teclado otimizado para email
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'seu.email@example.com',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O email é obrigatório.';
                  }
                  if (!value.contains('@') || !value.contains('.')) {
                    return 'Digite um email válido.';
                  }
                  return null; // Retorna null se for válido
                },
              ),
              const SizedBox(height: 20),

              // Campo de Senha (TextFormField com obscureText e validação)
              TextFormField(
                controller: _senhaController,
                obscureText: true, // Esconde o texto digitado
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  hintText: 'Mínimo 6 caracteres',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                  // Adicionando um ícone para "mostrar/esconder" a senha
                  suffixIcon: Icon(Icons.visibility_off),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'A senha é obrigatória.';
                  }
                  if (value.length < 6) {
                    return 'A senha deve ter pelo menos 6 caracteres.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),

              // Botão Elevado para Enviar o Formulário
              ElevatedButton.icon(
                onPressed: _enviarFormulario, // Chama a função de envio/validação
                icon: const Icon(Icons.send),
                label: const Text('Enviar Cadastro', style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Exemplo de TextButton
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Termos de Uso aceitos!')),
                  );
                },
                child: const Text('Leia nossos Termos de Uso'),
              ),
              const SizedBox(height: 30),

              // Exemplo de GestureDetector - tornando um Container "clicável"
              GestureDetector(
                onTap: () {
                  setState(() {
                    _toqueMensagem = 'Você tocou no container!';
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Container tocado!')),
                  );
                },
                onDoubleTap: () {
                   setState(() {
                    _toqueMensagem = 'Você deu um toque duplo!';
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Toque duplo!')),
                  );
                },
                onLongPress: () {
                   setState(() {
                    _toqueMensagem = 'Você segurou o container!';
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Toque longo!')),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  color: Colors.deepPurple.shade100,
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      const Icon(Icons.touch_app, size: 50, color: Colors.deepPurple),
                      const SizedBox(height: 10),
                      Text(
                        _toqueMensagem,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16, color: Colors.deepPurple),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Exemplo de como acessar o texto de um TextField "comum"
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Nome digitado (TextField): ${_nomeController.text}'),
                    ),
                  );
                },
                child: const Text('Ver nome digitado'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
