function esistenza_eliminazione(nome_file,i)

    if exist([nome_file '.f06'], 'file')
      delete([nome_file '.f06']);
    end
    if exist([nome_file '.txt'], 'file')
      delete([nome_file '.txt']);
    end
    if exist([nome_file '.DBALL'], 'file')
      delete([nome_file '.DBALL']);
    end
    if exist([nome_file '.MASTER'], 'file')
      delete([nome_file '.MASTER']);
    end
    if exist([nome_file '.f04'], 'file')
      delete([nome_file '.f04']);
    end
    if exist([nome_file '.IFPDAT'], 'file')
      delete([nome_file '.IFPDAT']);
    end
    if exist([nome_file '.h5'], 'file')
      delete([nome_file '.h5']);
    end
    if exist([nome_file '.log.' num2str(i-1)], 'file')
      delete([nome_file '.log.' num2str(i-1)]);
    end
    if exist([nome_file '.sts.' num2str(i-1)], 'file')
      delete([nome_file '.sts.' num2str(i-1)]);
    end

end

