module ApplicationHelper

  def admin_signed_in?
    user_signed_in? and current_user.admin?
  end

  # Faz uma formatação simples no texto, e detecta URLs e as transforma em links
  def formata_conteudo (texto) 
    simple_format(texto).gsub(URI.regexp, '<a href="\0">\0</a>').html_safe
  end
end
