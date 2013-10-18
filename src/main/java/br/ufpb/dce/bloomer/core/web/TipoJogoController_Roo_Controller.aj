// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package br.ufpb.dce.bloomer.core.web;

import br.ufpb.dce.bloomer.core.model.Jogo;
import br.ufpb.dce.bloomer.core.model.NivelTaxonomia;
import br.ufpb.dce.bloomer.core.model.Plafatorma;
import br.ufpb.dce.bloomer.core.model.TipoJogo;
import br.ufpb.dce.bloomer.core.model.TipoQuestao;
import br.ufpb.dce.bloomer.core.model.Usuario;
import br.ufpb.dce.bloomer.core.web.TipoJogoController;
import java.io.UnsupportedEncodingException;
import java.util.Arrays;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;

privileged aspect TipoJogoController_Roo_Controller {
    
    @RequestMapping(method = RequestMethod.POST, produces = "text/html")
    public String TipoJogoController.create(@Valid TipoJogo tipoJogo, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, tipoJogo);
            return "tipojogoes/create";
        }
        uiModel.asMap().clear();
        tipoJogo.persist();
        return "redirect:/tipojogoes/" + encodeUrlPathSegment(tipoJogo.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(params = "form", produces = "text/html")
    public String TipoJogoController.createForm(Model uiModel) {
        populateEditForm(uiModel, new TipoJogo());
        return "tipojogoes/create";
    }
    
    @RequestMapping(value = "/{id}", produces = "text/html")
    public String TipoJogoController.show(@PathVariable("id") Long id, Model uiModel) {
        uiModel.addAttribute("tipojogo", TipoJogo.findTipoJogo(id));
        uiModel.addAttribute("itemId", id);
        return "tipojogoes/show";
    }
    
    @RequestMapping(produces = "text/html")
    public String TipoJogoController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            final int firstResult = page == null ? 0 : (page.intValue() - 1) * sizeNo;
            uiModel.addAttribute("tipojogoes", TipoJogo.findTipoJogoEntries(firstResult, sizeNo));
            float nrOfPages = (float) TipoJogo.countTipoJogoes() / sizeNo;
            uiModel.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            uiModel.addAttribute("tipojogoes", TipoJogo.findAllTipoJogoes());
        }
        return "tipojogoes/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT, produces = "text/html")
    public String TipoJogoController.update(@Valid TipoJogo tipoJogo, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, tipoJogo);
            return "tipojogoes/update";
        }
        uiModel.asMap().clear();
        tipoJogo.merge();
        return "redirect:/tipojogoes/" + encodeUrlPathSegment(tipoJogo.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(value = "/{id}", params = "form", produces = "text/html")
    public String TipoJogoController.updateForm(@PathVariable("id") Long id, Model uiModel) {
        populateEditForm(uiModel, TipoJogo.findTipoJogo(id));
        return "tipojogoes/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE, produces = "text/html")
    public String TipoJogoController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        TipoJogo tipoJogo = TipoJogo.findTipoJogo(id);
        tipoJogo.remove();
        uiModel.asMap().clear();
        uiModel.addAttribute("page", (page == null) ? "1" : page.toString());
        uiModel.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/tipojogoes";
    }
    
    void TipoJogoController.populateEditForm(Model uiModel, TipoJogo tipoJogo) {
        uiModel.addAttribute("tipoJogo", tipoJogo);
        uiModel.addAttribute("jogoes", Jogo.findAllJogoes());
        uiModel.addAttribute("niveltaxonomias", Arrays.asList(NivelTaxonomia.values()));
        uiModel.addAttribute("plafatormas", Arrays.asList(Plafatorma.values()));
        uiModel.addAttribute("tipoquestaos", TipoQuestao.findAllTipoQuestaos());
        uiModel.addAttribute("usuarios", Usuario.findAllUsuarios());
    }
    
    String TipoJogoController.encodeUrlPathSegment(String pathSegment, HttpServletRequest httpServletRequest) {
        String enc = httpServletRequest.getCharacterEncoding();
        if (enc == null) {
            enc = WebUtils.DEFAULT_CHARACTER_ENCODING;
        }
        try {
            pathSegment = UriUtils.encodePathSegment(pathSegment, enc);
        } catch (UnsupportedEncodingException uee) {}
        return pathSegment;
    }
    
}
